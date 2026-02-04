class_name HUD extends CanvasLayer

@onready var healthNode: CharacterHealth = $"../HealthNode" as CharacterHealth

@onready var label: Label = $Control/Label as Label
@onready var interaction_prompt: Panel = $Control/InteractionPrompt as Panel
@onready var interaction_prompt_label: Label = $Control/InteractionPrompt/Label as Label
@onready var control: Control = $Control as Control

var interaction_prompt_pos: Vector2
var default_prompt_text: String

func _ready() -> void:
    healthNode.health_changed.connect(process_health_change)
    interaction_prompt_pos = interaction_prompt.position
    default_prompt_text = interaction_prompt_label.text

func process_health_change(current_health: int) -> void:
    label.text = str(current_health)


func toggle_interaction_prompt(
        display: bool, text: String = default_prompt_text, position: Vector2 = interaction_prompt_pos
    ) -> void:
    interaction_prompt.visible = display
    interaction_prompt_label.text = text
    interaction_prompt.global_position = position - (interaction_prompt.size / 2)
