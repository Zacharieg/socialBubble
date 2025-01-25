extends Area2D
class_name Character

const MAX_HIT_POINT = 1
const HIT_WINDOW = 0.2

@onready var shield : Shield = $shield

@onready var hurtBox : CollisionShape2D = $hurtBox

func _ready() -> void:
	#position = get_viewport_rect().size / 2.
	hurtBox.shape = CircleShape2D.new()
	hurtBox.shape.radius = shield.SHIELD_RADIUS - shield.SHIELD_THICKNESS/2

func hit_ennemy(ennemy : Ennemy):
	ennemy.die()
	if not shield.is_ennemy_on_shields(ennemy):
		hurt()

func hurt():
	#get_tree().quit()
	print("do nothing")

func _on_area_entered(area: Area2D) -> void:
	if area is Ennemy:
		hit_ennemy(area)
