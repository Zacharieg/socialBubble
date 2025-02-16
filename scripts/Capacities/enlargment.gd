extends Capacity
class_name Enlargment

@export var shield_size_boost:= .2

func apply_effect(charac: Character):
	charac.shield.shield_size_boost = shield_size_boost;

func end_effect(charac: Character):
	charac.shield.shield_size_boost = 0
