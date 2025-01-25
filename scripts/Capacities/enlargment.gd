extends Capacity

@onready var timer : Timer = $Timer

@export var shield_size_boost:= 2. # multiplier

var character: Character
var added_size: float

func fire(charac: Character):
	super(charac)
	capacity_available = false
	print("d*** enlargment")
	character = charac
	added_size = character.shield.shield_size * shield_size_boost - character.shield.shield_size
	character.shield.add_size(added_size)
	timer.start()


func _on_timer_timeout() -> void:
	print("go back normal")
	capacity_available = true
	character.shield.add_size(-added_size)
