extends Node

signal song_started(song : AudioStreamPlayer2D)
signal song_finished

@onready var game_music : AudioStreamPlayer2D = $Lofi

var current_music_start_time : int = 0
var current_music : AudioStreamPlayer2D = null

func _ready() -> void:
	play_music(game_music)

func play_music(music : AudioStreamPlayer2D):
	if current_music:
		current_music.stop()
	
	current_music_start_time = Time.get_ticks_msec()
	current_music = music
	
	current_music.play()
	
	current_music.connect("finished", func(): play_music(current_music))
