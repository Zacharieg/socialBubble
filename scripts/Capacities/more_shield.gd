extends Capacity

@onready var timer : Timer = $Timer

var character: Character

func fire(charac: Character):
	super(charac)
	capacity_active = true
	charac.shield.shield_count += 2
	timer.start()

func _on_timer_timeout() -> void:
	capacity_active = false
	character.shield.shield_count -= 2
	
