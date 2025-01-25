extends Node2D
class_name Character

const MAX_HIT_POINT = 1

@onready var shield : Shield = $shield

func ready():
	position = get_viewport_rect().size / 2
