extends Sprite2D

var game_over_anim_finished = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Appuyer sur n'importe quelle touche relance le jeu
func _unhandled_input(event):
	if game_over_anim_finished : 
		print("en attente d'action après game over")
		if event is InputEventKey:
			get_tree().get_root().get_node("game").restart_game()
			game_over_anim_finished = false
