extends Area2D
class_name Character

signal hurted
signal dead
signal healed

# Vie = nombre de fois que le joueur peut être touché avant de mourir
@export var max_life = 3
@onready var life = max_life

const MAX_HIT_POINT = 1
const HIT_WINDOW = 0.2
const ACTION_COOLDOWN = 0.2

@onready var shield : Shield = $shield

@onready var hurtBox : CollisionShape2D = $hurtBox

@onready var capacity : Capacity = $MoreShield

var time_since_action : float = 100.

func _ready() -> void:
	#position = get_viewport_rect().size / 2.
	hurtBox.shape = CircleShape2D.new()
	hurtBox.shape.radius = shield.SHIELD_RADIUS - shield.SHIELD_THICKNESS/2

func _process(delta: float) -> void:
	time_since_action += delta
	if Input.is_action_just_pressed("action") && time_since_action > ACTION_COOLDOWN:
		$AnimationPlayer.play("bounce")
		time_since_action = 0.

func hit_ennemy(ennemy : Ennemy):
	ennemy.dead = true
	await get_tree().create_timer(HIT_WINDOW/2).timeout

	var impact_type = "impact_normal"
	
	if shield.is_ennemy_on_shields(ennemy):
		if time_since_action < HIT_WINDOW:
			impact_type = "impact_perfect"
			stop_perfect()
	else :
		impact_type = "impact_damage"
		hurt(ennemy)
	ennemy.die(impact_type)

func stop_perfect():
	capacity.reduce_capacity_cooldown()
	
	
func hurt(ennemy : Ennemy):
	life -= 1
	emit_signal("hurted")
	if life == 0 : 
		emit_signal("dead")
	
	$bubble/bubble_sprite.rotation = ennemy.rotation
	$bubble/bubble_sprite.play("impact")
	await $bubble/bubble_sprite.animation_finished
	$bubble/bubble_sprite.play("default")

func _on_upgrade(mod : Upgrades.Modifier):
	print("apply")
	print(mod)
	mod.modify(self)

func _on_capacity_fired(cap : Capacity) -> void:
	cap.apply_effect(self)
	$capa_effect.play("capa_effect")

func _on_capacity_ended(cap : Capacity) -> void:
	cap.end_effect(self)
