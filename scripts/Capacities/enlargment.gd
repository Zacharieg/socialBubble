extends Capacity

@export var shield_size_boost:= 1.5 # multiplier

var character: Character

func fire(char: Character):
	super(char)
	print("bitch")
	character = char
	char.shield.shield_size *= shield_size_boost
