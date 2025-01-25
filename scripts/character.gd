extends Area2D
class_name Character

const MAX_HIT_POINT = 1

@onready var shield : Shield = $shield

@onready var hurtBox : CollisionShape2D = $hurtBox

func _ready() -> void:
	position = get_viewport_rect().size / 2.
	hurtBox.shape = CircleShape2D.new()
	hurtBox.shape.radius = shield.SHIELD_RADIUS - shield.SHIELD_THICKNESS/2

func hit_ennemy(ennemy : Area2D):
	var ennemy_angle = ennemy.rotation
	ennemy.die()
	if ennemy_angle < shield.get_start_angle() or ennemy_angle > shield.get_end_angle():
		hurt()

func hurt():
	get_tree().quit()

func _on_area_entered(area: Area2D) -> void:
	if area is Ennemy:
		hit_ennemy(area)
