extends Area2D

@export var damage_amount: float = 25

@onready var controller: Enemy = self.get_parent() as Enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _on_area_entered(area: Area2D) -> void:
    print("Hlleo world")


func _on_body_entered(body: Node2D) -> void:

    if body is not Player:
        return

    controller.state_machine.change_state("AttackState")    
