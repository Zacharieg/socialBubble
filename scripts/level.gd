extends Node2D

var day_timer: Timer
var current_day = 1
var difficulty_frequency_diminishing = 0.2
var difficulty_increase_angle = 10
const DAYS_DURATION = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().size / 2.
	create_timer()
	pass # Replace with function body.
	
func create_timer():
	# Créer un timer
	day_timer = Timer.new()
	day_timer.name = "day_timer"
	add_child(day_timer)
	
	# Connecter le signal timeout du timer à la fonction spawnEnnemy
	day_timer.connect("timeout", Callable(self, "finish_day"))
	
	new_day()
	pass
	
func new_day():
	#print("the day starts")
	#print("Current day : ", current_day)
	get_tree().get_root().get_node("game/ui/foreground/day_label").text = str("Jour n° ", current_day)
	
	# Mettre en pause le spawner
	get_tree().get_root().get_node("game/ennemy_spawner").pause_spawner()
	
	# Lancer l'anim
	get_tree().get_root().get_node("game/ui/foreground/AnimationPlayer").play("new_day")
	

	
func start_new_day_after_anim():
	#Les ennemis sont générés de plus en plus fréquemment
	get_tree().get_root().get_node("game/ennemy_spawner").inbetween_spawning_time -= difficulty_frequency_diminishing
	get_tree().get_root().get_node("game/ennemy_spawner").set_spawning_timer()
	
	#L'angle de génération des ennemis est de plus en plus élevé
	
	get_tree().get_root().get_node("game/ennemy_spawner").difficulty_angle_max += PI/4
	
	set_day_timer()
	pass

func set_day_timer():
	position = get_viewport_rect().size / 2.
	
	# Configurer le timer pour qu'il se déclenche toutes les X secondes
	day_timer.set_wait_time(DAYS_DURATION)
	day_timer.set_one_shot(true)
	
	# Démarrer le timer
	day_timer.start()

func finish_day():
	current_day += 1
	new_day()
	pass
