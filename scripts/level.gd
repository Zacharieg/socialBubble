extends Node2D

var day_timer: Timer
var current_day = 1
var difficulty_frequency_diminishing = 0.5
const DAYS_DURATION = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().size / 2.
	
	new_day()
	
	pass # Replace with function body.
	
	
func new_day():
	print("the day starts")
	#print("Current day : ", current_day)
	get_tree().get_root().get_node("game/ui/Label").text = str("Jour n° ", current_day)
	get_tree().get_root().get_node("game/ennemy_spawner").inbetween_spawning_time -= difficulty_frequency_diminishing
	get_tree().get_root().get_node("game/ennemy_spawner").set_spawning_timer()
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
