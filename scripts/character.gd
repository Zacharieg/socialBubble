extends Area2D
class_name Character

# Vie = nombre de fois que le joueur peut être touché avant de mourir
@export var max_life = 3
@onready var life = max_life

const MAX_HIT_POINT = 1
const HIT_WINDOW = 0.2

@onready var shield : Shield = $shield

@onready var hurtBox : CollisionShape2D = $hurtBox

@onready var capacity : Capacity = $Enlargment

@onready var jauge = $bubble/jauge

var time_since_action : float = 100.


func _ready() -> void:
	#position = get_viewport_rect().size / 2.
	get_tree().get_root().get_node("game/ui/VBoxContainer/life_label").text = str("PV : ", life)
	hurtBox.shape = CircleShape2D.new()
	hurtBox.shape.radius = shield.SHIELD_RADIUS - shield.SHIELD_THICKNESS/2

func _process(delta: float) -> void:
	time_since_action += delta
	var jaugeMat = jauge.material
	if jaugeMat is ShaderMaterial:
		jaugeMat.set_shader_parameter('fV', 1. - max(0., capacity.capacity_current_cooldown) / capacity.capacity_base_cooldown)
	if Input.is_action_pressed("action"):
		time_since_action = 0.
		if not capacity.capacity_active and capacity.capacity_current_cooldown <= 0.:
			capacity.fire(self)

func hit_ennemy(ennemy : Ennemy):
	ennemy.dead = true
	await get_tree().create_timer(HIT_WINDOW/2).timeout
	var perfect_stop = false
	
	if shield.is_ennemy_on_shields(ennemy):
		perfect_stop = time_since_action < HIT_WINDOW
		if perfect_stop:
			stop_perfect()
	else :
		hurt(ennemy)
	ennemy.die(perfect_stop)

func stop_perfect():
	print("stop perfect")
	if capacity.capacity_current_cooldown > 0.:
		capacity.capacity_current_cooldown -= capacity.TIME_GAINED_WHEN_PERFECT
		print(capacity.capacity_current_cooldown)

func hurt(ennemy : Ennemy):
	life -= 1
	get_tree().get_root().get_node("game/ui/VBoxContainer/life_label").text = str("PV : ", life)
	if life == 0:game_over()
	$bubble/bubble_sprite.rotation = ennemy.rotation
	$bubble/bubble_sprite.play("impact")
	await $bubble/bubble_sprite.animation_finished
	$bubble/bubble_sprite.play("default")

func game_over():
	get_tree().quit()

func _on_area_entered(area: Area2D) -> void:
	if area is Ennemy:
		hit_ennemy(area)
