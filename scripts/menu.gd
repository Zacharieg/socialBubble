extends Control

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	get_tree().paused = false

func _input(event) :
	if event.is_pressed():
		if event.is_action_pressed("pause"):
			get_tree().quit()
		else:
			get_tree().change_scene_to_file("res://scenes/intro.tscn")
	
	
