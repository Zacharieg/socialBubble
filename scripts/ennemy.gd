extends Area2D
class_name Ennemy

@export var speed = 220

var dead = false

func _process(delta: float) -> void:
	move_to(delta)

func move_to(delta):
	if not dead :
		var direction = Vector2.LEFT.rotated(rotation).normalized()
		position += direction * speed * delta

func spawn():
	pass

func die(perfect_block = false):
	dead = true
	$AnimatedSprite2D.play("impact_perfect" if perfect_block else "impact_normal")
	await $AnimatedSprite2D.animation_finished
	queue_free()
