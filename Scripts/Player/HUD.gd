extends CanvasLayer

@onready var healthNode: CharacterHealth = $"../HealthNode"

@onready var label: Label = $Control/Label

func _ready() -> void:
	healthNode.health_changed.connect(process_health_change)

func process_health_change(current_health: int) -> void:
	label.text = str(current_health)
	
