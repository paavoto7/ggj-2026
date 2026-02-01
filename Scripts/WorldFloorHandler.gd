extends StaticBody2D

@onready var trigger: Area2D = $Area2D as Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Player:
        body.get_node("HealthNode")._died()
    pass # Replace with function body.
