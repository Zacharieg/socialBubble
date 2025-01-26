extends Node2D

signal next_day

@export var ennemy_spawner : EnnemySpawner

var song_bpm = 76
var game_bpm = 38

var current_day = 0
const DAYS_DURATION = 30000
const TIME_WITHOUT_ENNEMY = 5000

var time_day_started : int
var time_without_ennemies : int
var time_end_day : int = 0

var ennemy_queue : Array[Ennemy] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().size / 2.

func _process(delta: float) -> void:
	if Time.get_ticks_msec() > time_end_day:
		new_day()

func new_day():
	current_day += 1
	emit_signal("next_day", current_day)
	
	if current_day%5 == 0 && game_bpm < 50:
		game_bpm *= 2

	ennemy_spawner.difficulty_angle_max += PI/8
	ennemy_spawner.ennemy_speed += 10

	time_day_started = Time.get_ticks_msec()
	
	time_end_day = time_day_started + DAYS_DURATION
	
	spawn_day_ennemies()
	

func spawn_day_ennemies():
	
	var song_minute_per_bit = 1/float(song_bpm)
	var song_ms_ber_bit = int(song_minute_per_bit*60000) 
	
	var game_minute_per_bit = 1/float(game_bpm)
	var game_ms_ber_bit = int(game_minute_per_bit*60000) 
	
	var ennemy_arriving = time_day_started + TIME_WITHOUT_ENNEMY
	var first_hit = ennemy_arriving + Music.current_music_start_time % song_ms_ber_bit
	
	var hits_time = range(
		first_hit,
		time_end_day,
		game_ms_ber_bit,
	)
	
	for hit_time in hits_time:
		ennemy_spawner.spawn_ennemy(hit_time)

func finish_day():
	current_day += 1
	new_day()
	pass
