extends Node2D
class_name EnnemySpawner

@onready var spawn_dist = get_viewport_rect().size.x/2
@onready var inbetween_spawning_time = 2.0
@onready var inbetween_rand_time = 0.0

var timer: Timer

func _ready():
	set_spawning_timer()
	
func set_spawning_timer():
	position = get_viewport_rect().size / 2.
	
	# Créer un timer
	timer = Timer.new()
	add_child(timer)
	
	# Configurer le timer pour qu'il se déclenche toutes les 2 secondes
	#randomize value
	inbetween_rand_time = randf_range(0.0, 0.5)
	if inbetween_spawning_time + inbetween_rand_time <= 0.1:
		timer.set_wait_time(0.1)
	else:
		timer.set_wait_time(inbetween_spawning_time + inbetween_rand_time)
	print("wait time", timer.wait_time)
	timer.set_one_shot(false)
	
	# Connecter le signal timeout du timer à la fonction spawnEnnemy
	timer.connect("timeout", Callable(self, "spawnEnnemy"))
	
	# Démarrer le timer
	timer.start()

func spawnEnnemy():
	
	var initial_pos = Vector2(0,0)
	var initial_angle = deg_to_rad(randi_range(0,359))
	var x_from_character = cos(initial_angle) * spawn_dist
	var y_from_character = sin(initial_angle) * spawn_dist
	var center = get_viewport_rect().size / 2
	
	initial_pos = Vector2(x_from_character, y_from_character) + center
	
	var ennemy = preload("res://objects/ennemy.tscn").instantiate()
	ennemy.position = initial_pos
	ennemy.rotation = initial_angle
	get_tree().get_root().get_node("game").add_child(ennemy)
