extends Capacity

@export var shield_size_boost:= 2. # multiplier

var added_size: float

func apply_effect(charac: Character):
	added_size = charac.shield.shield_size * shield_size_boost - charac.shield.shield_size
	charac.shield.add_size(added_size)

func end_effect(charac: Character):
	charac.shield.add_size(-added_size)
