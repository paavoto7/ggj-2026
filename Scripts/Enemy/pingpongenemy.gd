extends Area2D

@export var max_val: Vector2 = Vector2.ZERO
@export var min_val: Vector2 = Vector2.ZERO
@export var movement_speed: float = 2
@export var damage_amount: float = 25

@onready var floor_detector: RayCast2D = $FloorDetector as RayCast2D
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    #add_to_group("interactables")
    max_val.y = global_position.y
    min_val.y = global_position.y
    pass

var elapsed_time: float = 0
func _physics_process(delta: float) -> void:
    # Just copying from worldmask
    elapsed_time += delta * movement_speed
    var t: float = (sin(elapsed_time) + 1.0) * 0.5 # converts -1..1 → 0..1
    var value: Vector2 = lerp(min_val, max_val, t)
    position = value

    if not floor_detector.is_colliding():
        position.x *= -1;
        anim_sprite.scale.x *= -0.8


func _on_body_enter(body: CharacterBody2D) -> void:
    # Remove from current parent before adding to inventory
    
    if body is not Player:
        return
    
    body.get_node("HealthNode").take_damage(damage_amount)
    
