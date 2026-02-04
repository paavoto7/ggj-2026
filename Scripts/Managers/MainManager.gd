extends Node

@export var background_music: AudioStream = preload("res://Assets/Audio/TestingMusicS.mp3")

var current_game_data: GameData
const save_data_path: String = "user://gamedata.tres"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    AudioManager.play_music(background_music)

func _enter_tree() -> void:
    _load_game_data()

func _notification(what: int) -> void:
    if what == NOTIFICATION_WM_CLOSE_REQUEST:
        _save_game_data()

func _exit_tree() -> void:
    _save_game_data()

func pause_game():
    get_tree().paused = true

func resume_game():
    get_tree().paused = false

func _save_game_data() -> void:
    ResourceSaver.save(current_game_data, save_data_path)

func _load_game_data() -> void:
    if ResourceLoader.exists(save_data_path):
        current_game_data = ResourceLoader.load(save_data_path, "GameData")
    else:
        _reset_game_data()

func _reset_game_data() -> void:
    current_game_data = GameData.new()
