extends Node2D

signal next_day

var day_timer: Timer
var current_day = 1
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
	emit_signal("next_day", current_day)
	
	set_day_timer()

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
