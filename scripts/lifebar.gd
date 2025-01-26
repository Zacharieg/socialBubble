extends MarginContainer

var life_point_sprites = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_life(get_tree().get_root().get_node("game/character").max_life)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init_life(total_life_points):
	print(total_life_points)
	for i in total_life_points:
		var life_scene = preload("res://objects/life_point.tscn")
		life_scene = life_scene.instantiate()
		get_node("lifepoint_separator").add_child(life_scene)
		
		#Le noeud instancié et ajouté à l'arborescence est ajouté dans le tableau
		#life_point_sprites.append(life_point_instance)
	pass
	
func decrease_life(damage):
	var lifebar = get_node("lifepoint_separator")
	var life_points = lifebar.get_children()
	
	for i in range(min(damage, life_points.size())):
		if not life_points.is_empty():
			var life_point_to_remove = life_points.pop_back()
			var sprite = life_point_to_remove.get_node("life_point_sprite")
			sprite.play("disappears")
			
			# Connecter le signal animation_finished avec le bon nombre d'arguments
			sprite.connect("animation_finished", Callable(self, "_on_disappear_animation_finished").bind(life_point_to_remove))

func _on_disappear_animation_finished(life_point: Node):
	life_point.queue_free()

func increase_life(additionnal_life_point):
	var life_scene = preload("res://objects/life_point.tscn")
	life_scene = life_scene.instantiate()
	get_node("lifepoint_separator").add_child(life_scene)
	print("life point added")
	pass

func _on_character_hurted() -> void:
	decrease_life(1)
	pass # Replace with function body.


func _on_character_healed() -> void:
	increase_life(1)
	pass # Replace with function body.
