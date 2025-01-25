extends Area2D
class_name Character

const MAX_HIT_POINT = 1
const HIT_WINDOW = 0.2

@onready var shield : Shield = $shield

@onready var hurtBox : CollisionShape2D = $hurtBox

var time_since_action : float = 100.

func _ready() -> void:
	#position = get_viewport_rect().size / 2.
	hurtBox.shape = CircleShape2D.new()
	hurtBox.shape.radius = shield.SHIELD_RADIUS - shield.SHIELD_THICKNESS/2

func _process(delta: float) -> void:
	time_since_action += delta
	if Input.is_action_pressed("action"):
		time_since_action = 0.

func hit_ennemy(ennemy : Ennemy):
	ennemy.dead = true
	await get_tree().create_timer(HIT_WINDOW/2).timeout
	var perfect_stop = false
	
	if shield.is_ennemy_on_shields(ennemy):
		perfect_stop = time_since_action < HIT_WINDOW
		stop_perfect()
	else :
		hurt()
	ennemy.die(perfect_stop)

func stop_perfect():
	pass

func hurt():
	get_tree().quit()
	#print("do nothing")

func _on_area_entered(area: Area2D) -> void:
	if area is Ennemy:
		hit_ennemy(area)
