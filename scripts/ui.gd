extends CanvasLayer

signal any_action_pressed
const DAY_PASS_TIME = 1.

func _input(event: InputEvent) -> void:
	emit_signal("any_action_pressed")

func day_pass(day_nb):
	get_tree().paused = true
	
	if day_nb != 1 : 
		$out_game_panel/container/upgrades.visible = true
		$out_game_panel/container/upgrades.setup_upgrades()
		$out_game_panel/container/subtitle.text = "Choisissez une amélioration"
	else :
		$out_game_panel/container/upgrades.visible = false
		$out_game_panel/container/subtitle.text = "Bon Courage  !"
		
	$out_game_panel/container/title.text = "Jour " + str(day_nb)
	
	$ui_animation.play("ui_fade_in")
	await $ui_animation.animation_finished
	
	if day_nb != 1 :
		await $out_game_panel/container/upgrades.upgrade
	else :
		await get_tree().create_timer(DAY_PASS_TIME).timeout
	
	$ui_animation.play("ui_fade_out")
	await $ui_animation.animation_finished
	get_tree().paused = false

func game_over():
	$out_game_panel/container/upgrades.visible = false
	$out_game_panel/container/title.text = "Vous avez perdu"
	$out_game_panel/container/subtitle.text = "Appuyez sur n'importe quel bouton pour réessayer"
	$ui_animation.play("ui_fade_in")
	get_tree().paused = true
	
	await self.any_action_pressed
	
	get_tree().reload_current_scene()
