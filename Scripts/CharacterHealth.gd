class_name CharacterHealth extends Node2D

@export var MAX_HEALTH: int = 100
@export var health: int = MAX_HEALTH

@export var death_sound: AudioStream = null
@export var hurt_sound: AudioStream = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func take_damage(amount: int) -> void:
    health -= amount

    if (health <= 0):
        _died()
    else:
        AudioManager.play_sfx_2d(hurt_sound, global_position)

func _died() -> void:
    AudioManager.play_sfx_2d(death_sound, global_position)
    if self.get_parent() is Player:
        $"../GameOver".game_over()
    else:
        get_parent().queue_free()
