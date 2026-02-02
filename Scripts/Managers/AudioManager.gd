extends Node

@export var music_bus := "Music"
@export var sfx_bus := "SFX"
@export var ui_bus := "UI"

var music_player: AudioStreamPlayer
var ui_player: AudioStreamPlayer

func _ready() -> void:
	# Persistent music player
	music_player = AudioStreamPlayer.new()
	music_player.bus = music_bus
	music_player.autoplay = false
	add_child(music_player)

	# UI player (non-spatial)
	ui_player = AudioStreamPlayer.new()
	ui_player.bus = ui_bus
	add_child(ui_player)

# Music player
func play_music(stream: AudioStream, loop := true) -> void:
	if music_player.stream == stream and music_player.playing:
		return

	music_player.stop()
	music_player.stream = stream
	music_player.play()

func stop_music() -> void:
	music_player.stop()

# UI SFX
func play_ui(stream: AudioStream) -> void:
	ui_player.stream = stream
	ui_player.play()

var asplayer: AudioStreamPlayer2D

# World SFX
func play_sfx_2d(stream: AudioStream, pos: Vector2, volume_db := 0.0) -> void:
	if stream == null:
		return
	
	if asplayer == null:
		asplayer = AudioStreamPlayer2D.new()

	# Need to pool these, but quick and dirty minor optimisation
	var p: AudioStreamPlayer2D = AudioStreamPlayer2D.new() if asplayer.playing else asplayer

	p.stream = stream
	p.bus = sfx_bus
	p.global_position = pos
	p.volume_db = volume_db

	add_child(p)
	p.play()

	p.finished.connect(p.queue_free)
