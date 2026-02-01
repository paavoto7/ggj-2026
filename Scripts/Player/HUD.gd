extends CanvasLayer

@onready var healthNode: CharacterHealth = $"../HealthNode"

@onready var label: Label = $Control/Label

func _process(delta: float) -> void:
	label.text = str(healthNode.health)
