extends Node

@onready var parent: Node2D = self.get_parent()

@export var max_val: float = .25
@export var min_val: float = -.25
@export var hover_speed: float = 2

var elapsed_time: float = 0
func _physics_process(delta: float) -> void:
    elapsed_time += delta * hover_speed
    var t = (sin(elapsed_time) + 1.0) * 0.5 # converts -1..1 → 0..1
    var value = lerp(min_val, max_val, t)
    parent.position.y += value
