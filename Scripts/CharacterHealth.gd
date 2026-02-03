class_name CharacterHealth extends Node2D

@export var MAX_HEALTH: int = 100
@export var health: int = MAX_HEALTH

signal health_changed(current_health: int)
signal character_died

@export var death_sound: AudioStream = null
@export var hurt_sound: AudioStream = null


func take_damage(amount: int) -> void:
    health -= amount
    health_changed.emit(health)

    if (health <= 0):
        _died()
    else:
        AudioManager.play_sfx_2d(hurt_sound, global_position)

func give_health(amount: int):
    health += amount

    if health > MAX_HEALTH:
        health = MAX_HEALTH
    
    health_changed.emit(health)
    #AudioManager.play_sfx_2d(health_sound, global_position)

func _died() -> void:
    AudioManager.play_sfx_2d(death_sound, global_position)

    character_died.emit()
