extends Node

@export var background_music: AudioStream = preload("res://Assets/Audio/TestingMusicS.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    AudioManager.play_music(background_music)
    pass # Replace with function body.


