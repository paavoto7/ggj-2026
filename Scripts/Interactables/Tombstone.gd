@tool
class_name Tombstone extends Interactable

@export var tombstone_sprite: CompressedTexture2D
# Just some sound
@export var mask_pickup_sound: AudioStream = preload("res://Assets/Audio/MaskPickUpS.wav")
@export var mask_hover_anim: String = "Forest"
@export var mask_id: String = ""

enum LevelNumber {
    Hub = 0,
    Level1 = 1,
    Level2 = 2,
    Level3 = 3,
    Level4 = 4,
}

# Set in editor based on the level we want to load
@export var level_number: LevelNumber = LevelNumber.Hub

var collected: bool = false

func _ready() -> void:
    super._ready()
    $TombSprite.texture = tombstone_sprite
    $MaskHover.animation = mask_hover_anim
    
    _initialise()

func interact(_player: Player) -> void:
    if collected:
        return
    
    AudioManager.play_sfx_2d(mask_pickup_sound, self.global_position)

    var scene_to_load: String = "res://Scenes/levels/level%d.tscn" % level_number
    if level_number == LevelNumber.Hub:
        scene_to_load = "res://Scenes/levels/hub.tscn"
    
    MainManager.current_game_data.last_hub_tombstone = "LevelTombstone%d" % level_number
    
    get_tree().change_scene_to_file(scene_to_load)

func _initialise() -> void:
    if MainManager.current_game_data.collected_masks.has(mask_id):
        $MaskHover.visible = true
        collected = true
        prompt_text = "Already collected"
