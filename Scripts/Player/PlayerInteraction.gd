extends Area2D

@onready var player: Player = self.get_parent() as Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Not ideal in any way, but works for now
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("interact"):
		for body in get_overlapping_areas():
			if body.is_in_group("interactables"):
				body.interact(player)  # Call a method on the interactable
