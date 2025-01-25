extends Area2D
class_name Ennemy

const SPEED = 100

func _process(delta: float) -> void:
	
	move_to(get_tree().get_root().get_node("game/character").position, delta)

func move_to(destination, delta):
	var direction = Vector2.LEFT.rotated(rotation).normalized()
	position += direction * SPEED * delta

func spawn():
	pass

func die():
	pass
