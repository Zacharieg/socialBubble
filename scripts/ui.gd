extends CanvasLayer

signal any_action_pressed

var game_paused := false

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		if event.is_action_pressed("pause"):
			get_tree().change_scene_to_file("res://main.tscn")
		else:
			emit_signal("any_action_pressed")
	#print(event)

func day_pass(day_nb):
	$day/Label.text = "Day: " + str(day_nb)
	
	get_tree().paused = true
	#print("day nb ", day_nb)
	if day_nb != 1 : 
		$out_game_panel/container/upgrades.visible = true
		$out_game_panel/container/upgrades.setup_upgrades()
		$out_game_panel/container/subtitle.text = "Choose an upgrade"
	else :
		$out_game_panel/container/upgrades.visible = false
		$out_game_panel/container/subtitle.text = "Good luck!"
		
	$out_game_panel/container/title.text = "Day " + str(day_nb)
	
	if day_nb == 1:$ui_animation.play("ui_display_after_intro")
	else:$ui_animation.play("ui_fade_in")
	
	await $ui_animation.animation_finished
	
	if day_nb != 1 :
		await $out_game_panel/container/upgrades.upgrade
	
	$ui_animation.play("ui_fade_out")
	await $ui_animation.animation_finished
	get_tree().paused = false
	$"../level".spawn_day_ennemies()

func game_over():
	$out_game_panel/container/upgrades.visible = false
	$"../character".visible = false
	$out_game_panel/container/title.text = "Game Over"
	$out_game_panel/container/subtitle.text = "Press escape to leave or any other button to restart"
	
	$"../level/character_Sprite2D/AnimationPlayer".stop()
	$"../level/character_Sprite2D".play("game_over")
	await $"../level/character_Sprite2D".animation_finished
	
	get_tree().paused = true
	$ui_animation.play("ui_fade_in")
	
	await get_tree().create_timer(1).timeout
	await self.any_action_pressed
	
	get_tree().paused = false
	get_tree().reload_current_scene()
