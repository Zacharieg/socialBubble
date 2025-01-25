extends Area2D
class_name Character

# Vie = nombre de fois que le joueur peut être touché avant de mourir
@export var max_life = 3
@onready var life = max_life

const MAX_HIT_POINT = 1
const HIT_WINDOW = 0.2

@onready var shield : Shield = $shield

@onready var hurtBox : CollisionShape2D = $hurtBox

var time_since_action : float = 100.

func _ready() -> void:
	#position = get_viewport_rect().size / 2.
	get_tree().get_root().get_node("game/ui/VBoxContainer/life_label").text = str("PV : ", life)
	hurtBox.shape = CircleShape2D.new()
	hurtBox.shape.radius = shield.SHIELD_RADIUS - shield.SHIELD_THICKNESS/2

func _process(delta: float) -> void:
	time_since_action += delta
	if Input.is_action_pressed("action"):
		time_since_action = 0.

func hit_ennemy(ennemy : Ennemy):
	ennemy.dead = true
	await get_tree().create_timer(HIT_WINDOW/2).timeout
	var perfect_stop = false
	
	if shield.is_ennemy_on_shields(ennemy):
		perfect_stop = time_since_action < HIT_WINDOW
		stop_perfect()
	else :
		hurt()
	ennemy.die(perfect_stop)

func stop_perfect():
	pass

func hurt():
	life -= 1
	get_tree().get_root().get_node("game/ui/VBoxContainer/life_label").text = str("PV : ", life)
	if life == 0:game_over()
	#print("do nothing")
	
func game_over():
	get_tree().quit()

func _on_area_entered(area: Area2D) -> void:
	if area is Ennemy:
		hit_ennemy(area)
