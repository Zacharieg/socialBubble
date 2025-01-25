extends Node2D
class_name EnnemySpawner

@onready var spawn_dist = get_viewport_rect().size.x/2
@export var inbetween_spawning_time = 2.0
@onready var inbetween_rand_time = 0.0
@onready var initial_angle = 0

@export var difficulty_angle_max = 100

var timer: Timer

func _ready():
	create_spawing_timer()
	#set_spawning_timer()

func create_spawing_timer():
	# Créer un timer
	timer = Timer.new()
	timer.name = "spawing_timer"
	add_child(timer)
	
	# Connecter le signal timeout du timer à la fonction spawnEnnemy
	timer.connect("timeout", Callable(self, "spawnEnnemy"))

func set_spawning_timer():
	position = get_viewport_rect().size / 2.
	# Configurer le timer pour qu'il se déclenche toutes les 2 secondes
	#randomize value
	inbetween_rand_time = randf_range(0.0, 0.5)
	if (inbetween_spawning_time + inbetween_rand_time) <= 0.1:
		timer.set_wait_time(0.1)
	else:
		timer.set_wait_time(inbetween_spawning_time + inbetween_rand_time)
	timer.set_one_shot(false)
	
	# Démarrer le timer
	timer.start()

func spawnEnnemy():
	var initial_pos = Vector2(0,0)
	initial_angle = deg_to_rad(randi_range(initial_angle,initial_angle+difficulty_angle_max))
	var x_from_character = cos(initial_angle) * spawn_dist
	var y_from_character = sin(initial_angle) * spawn_dist
	var center = get_viewport_rect().size / 2
	
	initial_pos = Vector2(x_from_character, y_from_character) + center
	
	var ennemy = preload("res://objects/ennemy.tscn").instantiate()
	ennemy.position = initial_pos
	ennemy.rotation = initial_angle
	get_tree().get_root().get_node("game").add_child(ennemy)
	
func pause_spawner():
	timer.stop()


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().get_root().get_node("game/level").start_new_day_after_anim()
	pass # Replace with function body.
