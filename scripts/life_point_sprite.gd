extends AnimatedSprite2D

func _ready():
	# Assurez-vous que l'animation est configurée pour jouer en boucle
	self.set_sprite_frames(self.get_sprite_frames())
	
	# Obtenir le nombre total de frames dans l'animation
	var total_frames = self.sprite_frames.get_frame_count("default")
	
	# Générer un index de frame aléatoire
	var random_frame = randi() % total_frames
	
	# Définir le frame de départ aléatoire
	self.frame = random_frame
	
	# Démarrer l'animation à partir de ce frame
	self.play("default")
