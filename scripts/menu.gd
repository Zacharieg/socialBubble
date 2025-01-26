extends Control

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _unhandled_key_input(event) :
	if event.is_pressed():
		get_tree().change_scene_to_file("res://scenes/intro.tscn")
	
