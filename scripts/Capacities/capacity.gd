extends Node
class_name Capacity

signal capacity_fired

const TIME_GAINED_WHEN_PERFECT := 2.

@export var capacity_name : String = "NEW CAPACITY"
@export var capacity_base_cooldown : float = 1.
@export var capacity_time_effect : float = 1.

var capacity_current_cooldown : float
var capacity_current_time_effect : float
var capacity_active := false

func _ready() -> void:
	reset()

func reset():
	capacity_current_cooldown = capacity_base_cooldown
	capacity_current_time_effect = capacity_time_effect

func _process(delta: float) -> void:
	if capacity_current_cooldown > 0.:
		capacity_current_cooldown -= delta

func fire(_charac: Character):
	reset()
	capacity_fired.emit()
