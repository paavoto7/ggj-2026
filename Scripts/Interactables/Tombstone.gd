class_name Tombstone extends Interactable

# Just some sound
@export var mask_pickup_sound: AudioStream = preload("res://Assets/Audio/MaskPickUpS.wav")

enum LevelNumber {
    Hub = 0,
    Level1 = 1,
    Level2 = 2,
    Level3 = 3,
    Level4 = 4,
}

# Set in editor based on the level we want to load
@export var level_number: LevelNumber = LevelNumber.Hub


func interact(_player: Player) -> void:
    AudioManager.play_sfx_2d(mask_pickup_sound, self.global_position)

    var scene_to_load: String = "res://Scenes/levels/level%d.tscn" % level_number
    if level_number == LevelNumber.Hub:
        scene_to_load = "res://Scenes/levels/hub.tscn"
    
    MainManager.current_game_data.last_hub_tombstone = "LevelTombstone%d" % level_number
    
    get_tree().change_scene_to_file(scene_to_load)

    