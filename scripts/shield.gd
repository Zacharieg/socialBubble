extends Node2D
class_name Shield


const SHIELD_RADIUS : float = 62
const SHIELD_INITIAL_SIZE : float = 0.1
const SHIELD_THICKNESS : float = 10
const SHIELD_INITIAL_SPEED : float = 0.5
const INITIAL_SHIELD_COUNT : int = 1

var shield_speed : float = SHIELD_INITIAL_SPEED
var shield_size : float = SHIELD_INITIAL_SIZE # from 0 to 1
var shield_size_boost : float = 0 # from 0 to 1
var shield_position : float = 0 # from 0 to 1
var shield_count : int = INITIAL_SHIELD_COUNT
@export var shield_thickness = SHIELD_THICKNESS

func _ready() -> void:
	shield_position = .75 - .5 * shield_size

func _draw():
	for i in range(shield_count):
		var start_angle = get_start_angle(i)
		draw_arc(
			Vector2.ZERO,
			SHIELD_RADIUS,
			start_angle,
			start_angle + get_shield_circ(),
			100,
			Color.WHITE,
			shield_thickness
		)
		if shield_size_boost > 0:
			draw_arc(
				Vector2.ZERO,
				SHIELD_RADIUS,
				start_angle - PI * shield_size_boost / shield_count, # 2 * .5 simplified
				start_angle,
				100,
				Color(1,1,1,0.5),
				shield_thickness
			)
			draw_arc(
				Vector2.ZERO,
				SHIELD_RADIUS,
				start_angle + get_shield_circ(),
				start_angle + get_shield_circ() + PI * shield_size_boost / shield_count,
				100,
				Color(1,1,1,0.5),
				shield_thickness
			)

func _process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("left"):
		direction -= 1
	if Input.is_action_pressed("right"):
		direction += 1
	if direction != 0:
		move(direction, delta)
	queue_redraw()

func move(direction : int, delta : float): # direction is 1 or -1
	shield_position += direction * shield_speed * delta
	while shield_position > 1:
		shield_position -= 1
	while shield_position < 0:
		shield_position += 1

func get_start_angle(shield_number : int = 0):
	return float(shield_number)/shield_count * 2 * PI + 2 * PI * shield_position

func get_shield_circ():
	return shield_size * 2 * PI

func get_end_angle(shield_number : int = 0):
	var end_angle = get_start_angle(shield_number) + get_shield_circ()
	if end_angle > 2*PI:
		end_angle -= 2*PI
	return end_angle

func is_ennemy_on_shields(ennemy : Ennemy) -> bool:
	for i in range(shield_count):
		if is_ennemy_on_shield(ennemy, i):
			return true
	return false

func is_ennemy_on_shield(ennemy : Ennemy, shield_number : int = 0) -> bool:
	var ennemy_angle = fposmod(ennemy.rotation, 2 * PI)
	var start_angle = fposmod(get_start_angle(shield_number) - PI * shield_size_boost / shield_count, 2 * PI)
	var end_angle = fposmod(get_end_angle(shield_number) + PI * shield_size_boost / shield_count, 2 * PI)
	
	if start_angle < end_angle :
		return ennemy_angle > start_angle and ennemy_angle < end_angle
	else :
		return ennemy_angle < end_angle or ennemy_angle > start_angle

func add_size(addition: float):
	shield_position -= addition * .5
	shield_size += addition
	
func add_temp_size(addition: float):
	shield_size_boost += addition
