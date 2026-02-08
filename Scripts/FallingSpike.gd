extends Node2D

@onready var trigger_area: Area2D = $TriggerArea
@onready var trigger_area_collider: CollisionShape2D = $TriggerArea/CollisionShape2D
@onready var damage_area: Area2D = $DamageArea
@onready var damage_area_collider: CollisionShape2D = $DamageArea/CollisionShape2D

@export var fall_speed := 0.0
@export var GRAVITY := 1200.0
@export var MAX_FALL_SPEED := 2000.0

@export var damage: int = 25

@export var sprite: Sprite2D

var falling := false
var triggered := false

func _ready():
    trigger_area.body_entered.connect(_on_trigger_entered)
    damage_area.body_entered.connect(_on_damage_body_entered)
    damage_area.monitoring = false  # don't hurt until falling
    
    if sprite:
        # Get sprite size, taking scale into account
        var sprite_size = sprite.texture.get_size() * sprite.scale

        # Resize trigger area collider
        var trigger_shape = trigger_area_collider.shape as RectangleShape2D
        trigger_shape.extents.x = (sprite_size / 2).x

        # Resize damage area collider
        var damage_shape = damage_area_collider.shape as RectangleShape2D
        damage_shape.extents.x = (sprite_size / 2).x
        damage_shape.extents.y = (sprite_size / 4).y

        # Optional: align colliders with sprite
        trigger_area_collider.position = sprite.position
        damage_area_collider.position = sprite.position + Vector2(0, -sprite_size.y / 4)


func _simulate_falling_spike():
    await _start_fall_delay()
    while falling:
        fall_speed = min(fall_speed + GRAVITY * get_physics_process_delta_time(), MAX_FALL_SPEED)
        position.y += fall_speed * get_physics_process_delta_time()
        await get_tree().physics_frame
    queue_free()


func _on_trigger_entered(body):
    if triggered:
        return
        
    if body.is_in_group("player"):
        triggered = true
        falling = true
        _simulate_falling_spike()


func _start_fall_delay():
    await get_tree().create_timer(1.0).timeout
    falling = true
    damage_area.monitoring = true  # NOW it can deal damage


func _on_damage_body_entered(body):
    if body is TileMapLayer:
        return
    var health_node = body.get_node_or_null("HealthNode")
    if health_node and health_node.has_method("take_damage"):
        print("The player took damage")
        health_node.take_damage(damage)

    falling = false
