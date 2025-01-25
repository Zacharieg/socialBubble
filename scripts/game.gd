extends Node2D


func restart_game():
	# Réinitialisez ici toutes les variables nécessaires
	# Par exemple :
	#score = 0
	#player_health = 100
	
	# Rechargez la scène principale
	get_tree().reload_current_scene()
