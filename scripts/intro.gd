extends Node2D

var tuto_is_passed = false
@onready var tuto = $tuto
@onready var animation_player = $AnimationPlayer

func _input(event):
	if event.is_action_pressed("action"):
		if not tuto_is_passed:
			hide_tutorial()
		elif tuto_is_passed:
			start_game()

func hide_tutorial():
	tuto.queue_free()
	animation_player.play("idle")
	tuto_is_passed = true

func start_game():
	var next_scene = preload("res://scenes/game.tscn")
	get_tree().change_scene_to_packed(next_scene)
