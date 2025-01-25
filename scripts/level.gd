extends Node2D

var day_timer: Timer
var current_day = 1
var difficulty_frequency_diminishing = 0.2
var difficulty_increase_angle = 10
const DAYS_DURATION = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().size / 2.
	
	new_day()
	
	pass # Replace with function body.
	
	
func new_day():
	#print("the day starts")
	#print("Current day : ", current_day)
	get_tree().get_root().get_node("game/ui/VBoxContainer/day_label").text = str("Jour n° ", current_day)
	
	#Les ennemis sont générés de plus en plus fréquemment
	get_tree().get_root().get_node("game/ennemy_spawner").inbetween_spawning_time -= difficulty_frequency_diminishing
	get_tree().get_root().get_node("game/ennemy_spawner").set_spawning_timer()
	
	#L'angle de génération des ennemis est de plus en plus élevé
	if get_tree().get_root().get_node("game/ennemy_spawner").difficulty_angle_max + difficulty_increase_angle <= 359:
		get_tree().get_root().get_node("game/ennemy_spawner").difficulty_angle_max += difficulty_increase_angle
	else : get_tree().get_root().get_node("game/ennemy_spawner").difficulty_angle_max = 359
	set_day_timer()

func set_day_timer():
	position = get_viewport_rect().size / 2.
	
	# Créer un timer
	day_timer = Timer.new()
	add_child(day_timer)
	
	# Configurer le timer pour qu'il se déclenche toutes les 2 secondes
	day_timer.set_wait_time(DAYS_DURATION)
	day_timer.set_one_shot(true)
	
	# Connecter le signal timeout du timer à la fonction spawnEnnemy
	day_timer.connect("timeout", Callable(self, "finish_day"))
	
	# Démarrer le timer
	day_timer.start()

func finish_day():
	print("jour 1 terminé")
	current_day += 1
	new_day()
	pass
