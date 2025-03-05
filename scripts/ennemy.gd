extends Node2D
class_name Ennemy

const PLAYER_IMPACT_DISTANCE = 100

var speed = 50 #per seconds

var hit_time : int

var dead = false

var character : Character = null

func _ready() -> void:
	visible = false
	var delete = func(): queue_free()
	character.dead.connect(delete)

func _process(delta: float) -> void:
	if not dead:
		visible = true
		var time_since_arrive = hit_time - Time.get_ticks_msec()
		var distance_from_player = float(time_since_arrive)/1000 * speed + PLAYER_IMPACT_DISTANCE
		if time_since_arrive < 0:
			character.hit_ennemy(self)
			dead = true
		else :
			position = Vector2(
				cos(rotation)*distance_from_player,
				sin(rotation)*distance_from_player,
			) + character.position


func die(impact_type := "impact_perfect"):
	dead = true
	$Impact.play(impact_type)
	$Moving.hide()
	await $Impact.animation_finished
	queue_free()
