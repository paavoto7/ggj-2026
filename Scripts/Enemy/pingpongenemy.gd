extends Area2D

@export var max_val: Vector2 = Vector2.ZERO
@export var min_val: Vector2 = Vector2.ZERO
@export var movement_speed: float = 2
@export var damage_amount: float = 25
@export var pause_time: float = 0.3

@onready var floor_detector: RayCast2D = $FloorDetector as RayCast2D
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D

var target: Vector2
var pause_timer: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    max_val += position
    min_val += position

    max_val.y = position.y
    min_val.y = position.y
    
    target = max_val
    body_entered.connect(_on_body_enter)

func _physics_process(delta: float) -> void:
    if pause_timer > 0:
        pause_timer -= delta
        return

    position = position.lerp(target, movement_speed * delta)

    if position.distance_to(target) < 1.0:
        position = target
        target = min_val if target == max_val else max_val
        pause_timer = pause_time
        anim_sprite.scale.x *= -1

func _on_body_enter(body: Node2D) -> void:
    # Remove from current parent before adding to inventory
    
    if body is not Player:
        return
    
    body.get_node("HealthNode").take_damage(damage_amount)
    
