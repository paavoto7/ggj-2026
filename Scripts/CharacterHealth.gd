class_name CharacterHealth extends Node

@export var MAX_HEALTH: float = 100
@export var health: float = MAX_HEALTH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func take_damage(amount: float) -> void:
    health -= amount
    if (health <= 0):
        _died()

func _died() -> void:
    get_parent().queue_free()
    pass
