extends Node2D
class_name EnnemySpawner

const DEFAULT_MAX_ANGLE = PI/4
const DEFAULT_ENNEMY_SPEED = 20

@export var character : Character

@onready var spawn_dist = get_viewport_rect().size.x/2
@export var inbetween_spawning_time = 2.0
@onready var inbetween_rand_time = 0.0
@onready var last_angle : float = randf_range(0, 2*PI)
var difficulty_angle_max : float = DEFAULT_MAX_ANGLE
var ennemy_speed : float = DEFAULT_ENNEMY_SPEED

func get_enemy_new_angle() -> float:
	var new_angle : float = randf_range(
		last_angle - difficulty_angle_max/2.,
		last_angle + difficulty_angle_max/2.,
	)
	last_angle = new_angle
	return new_angle 

func spawn_ennemy(hit_time : int):
	var initial_pos = Vector2(0,0)
	var angle = get_enemy_new_angle()
	
	var ennemy = preload("res://objects/ennemy.tscn").instantiate()
	ennemy.rotation = angle
	ennemy.character = character
	ennemy.hit_time = hit_time
	ennemy.speed = ennemy_speed
	get_tree().get_root().get_node("game").add_child(ennemy)
