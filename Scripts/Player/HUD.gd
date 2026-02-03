class_name HUD extends CanvasLayer

@onready var healthNode: CharacterHealth = $"../HealthNode"

@onready var label: Label = $Control/Label
@onready var interaction_prompt: Panel = $Control/InteractionPrompt
@onready var control: Control = $Control as Control

var interaction_prompt_pos: Vector2

func _ready() -> void:
	healthNode.health_changed.connect(process_health_change)
	interaction_prompt_pos = interaction_prompt.position

func process_health_change(current_health: int) -> void:
	label.text = str(current_health)


func toggle_interaction_prompt(display: bool, position: Vector2 = interaction_prompt_pos) -> void:
	interaction_prompt.visible = display
	interaction_prompt.global_position = position - (interaction_prompt.size / 2)
