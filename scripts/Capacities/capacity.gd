extends Node
class_name Capacity

signal capacity_fired
signal capacity_ended

const TIME_COOLDOWN_GAINED_WHEN_PERFECT := 5.
const TIME_EFFECT_GAINED_WHEN_PERFECT := .5

@export var capacity_name : String = "NEW CAPACITY"
@export var capacity_base_cooldown : float = 1.
@export var capacity_base_duration : float = 1.
@export var jaugeSprite : Sprite2D
@onready var jaugeMat : ShaderMaterial = jaugeSprite.material

var capacity_jauge : float = 0
var capacity_cooldown : float = 0
var capacity_time : float = 0

var is_running = false

func _ready() -> void:
	is_running = false
	capacity_cooldown = 0.
	jaugeMat.set_shader_parameter('albedo', Color.WHITE)
	jaugeMat.set_shader_parameter('fV', capacity_jauge)

func _process(delta: float) -> void:
	if not is_running : 
		capacity_cooldown += delta
		capacity_jauge = capacity_cooldown/capacity_base_cooldown
		if capacity_cooldown > capacity_base_cooldown:
			fire()
	else:
		capacity_time -= delta
		capacity_jauge = capacity_time / capacity_base_duration
		if capacity_time < 0:
			end()
	
	
	jaugeMat.set_shader_parameter('fV', capacity_jauge)

func reduce_capacity_cooldown():
	capacity_cooldown += TIME_COOLDOWN_GAINED_WHEN_PERFECT
	capacity_time += TIME_EFFECT_GAINED_WHEN_PERFECT
	capacity_time = min(capacity_time, capacity_base_duration) 

func fire():
	is_running = true
	capacity_time = capacity_base_duration
	capacity_fired.emit(self)
	jaugeMat.set_shader_parameter('albedo', Color.YELLOW)

func end():
	is_running = false
	capacity_cooldown = 0.
	capacity_ended.emit(self)
	jaugeMat.set_shader_parameter('albedo', Color.WHITE)

func apply_effect(_charac : Character):
	pass

func end_effect(_charac : Character):
	pass
