extends Node2D

var intro_is_passed = false

func _unhandled_key_input(event) :
	if event.is_pressed():
		get_tree().change_scene_to_file("res://scenes/game.tscn")
