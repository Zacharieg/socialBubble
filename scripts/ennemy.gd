extends Area2D
class_name Ennemy

const SPEED = 200

func _process(delta: float) -> void:
	move_to(delta)

func move_to(delta):
	var direction = Vector2.LEFT.rotated(rotation).normalized()
	position += direction * SPEED * delta

func spawn():
	pass

func die():
	queue_free()
