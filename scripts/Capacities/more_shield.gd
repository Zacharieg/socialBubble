extends Capacity

@onready var timer : Timer = $Timer

func apply_effect(charac : Character):
	charac.shield.shield_count += 1

func end_effect(charac : Character):
	charac.shield.shield_count -= 1  
