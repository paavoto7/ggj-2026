class_name Interactable extends Area2D

@export var prompt_text: String
@export var prompt_position: Vector2 = Vector2.ZERO


func _ready() -> void:  
    # Could be added in editor as well
    add_to_group("interactables")


func interact(player: Player) -> void: pass
