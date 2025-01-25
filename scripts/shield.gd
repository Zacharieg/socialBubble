extends Node2D
class_name Shield

const SHIELD_RADIUS : float = 100
const SHIELD_INITIAL_SIZE : float = 0.2
const SHIELD_THICKNESS : float = 10
const SHIELD_INITIAL_SPEED : float = 1

var shield_speed : float = SHIELD_INITIAL_SPEED
var shield_size : float = SHIELD_INITIAL_SIZE # from 0 to 1
var shield_position : float = 0 # from 0 to 1

func _draw():
	draw_arc(
		Vector2.ZERO,
		SHIELD_RADIUS,
		get_start_angle(),
		get_start_angle() + get_shield_circ(),
		100,
		Color.WHITE,
		10
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

func get_start_angle():
	return 2 * PI * shield_position

func get_shield_circ():
	return shield_size * 2 * PI

func get_end_angle():
	var end_angle = 2 * PI * shield_position + get_shield_circ()
	if end_angle > 2*PI:
		end_angle -= 2*PI
	return end_angle
