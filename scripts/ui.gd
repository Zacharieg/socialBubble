extends CanvasLayer

signal any_action_pressed
const DAY_PASS_TIME = 1.

var game_paused := false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		if event.is_action_pressed("pause"):
			get_tree().change_scene_to_file("res://main.tscn")
		emit_signal("any_action_pressed")
				

func day_pass(day_nb):
	print("day pass")
	get_tree().paused = true
	
	if day_nb != 1 : 
		$out_game_panel/container/upgrades.visible = true
		$out_game_panel/container/upgrades.setup_upgrades()
		$out_game_panel/container/subtitle.text = "Choose an upgrade"
	else :
		$out_game_panel/container/upgrades.visible = false
		$out_game_panel/container/subtitle.text = "Good luck!"
		
	$out_game_panel/container/title.text = "Day " + str(day_nb)
	
	$ui_animation.play("ui_fade_in")
	await $ui_animation.animation_finished
	
	if day_nb != 1 :
		await $out_game_panel/container/upgrades.upgrade
	else :
		await get_tree().create_timer(DAY_PASS_TIME).timeout
	
	$ui_animation.play("ui_fade_out")
	await $ui_animation.animation_finished
	get_tree().paused = false
	$"../level".spawn_day_ennemies()

func game_over():
	$out_game_panel/container/upgrades.visible = false
	$out_game_panel/container/title.text = "Game Over"
	$out_game_panel/container/subtitle.text = "Press any button to continue"
	$ui_animation.play("ui_fade_in")
	get_tree().paused = true
	
	await get_tree().create_timer(1).timeout
	await self.any_action_pressed
	
	get_tree().paused = false
	get_tree().reload_current_scene()
