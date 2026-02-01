extends Area2D

@export var damage_amount: float = 25

@onready var controller: Enemy = self.get_parent() as Enemy


func _on_body_entered(body: Node2D) -> void:

	if body is not Player:
		return

	controller.state_machine.change_state("AttackState")    
