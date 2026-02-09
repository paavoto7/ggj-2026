class_name AnimationModulator extends Timer

# Needs to be a child of the animated sprite
@onready var sprite: AnimatedSprite2D = self.get_parent() as AnimatedSprite2D

var original_modulate: Color
@export var flashing_color: Color = Color(1, 1, 1, 0.5)
@export var flash_duration: float = 0.2  # Time for one flash cycle
@export var amount_of_flashes: int = 3
var is_flashing: bool = false

func _ready() -> void:
    original_modulate = sprite.modulate  # Store the original color
    timeout.connect(_on_timeout)

func start_flashing() -> void:
    _flash()
    return
    
    # These are here for future reference
    var flashes: int = amount_of_flashes
    while is_flashing && flashes > 0:
        await timeout
        flashes -= 1
        _flash()


func _flash(flash_time: float = flash_duration) -> void:
    is_flashing = true
    sprite.modulate = flashing_color
    start(flash_time)

func stop_flashing() -> void:
    is_flashing = false
    stop()
    sprite.modulate = original_modulate

func _on_timeout() -> void:
    if is_flashing:
        sprite.modulate = original_modulate
        is_flashing = false
