class_name Enemy extends CharacterBody2D

enum State {
    WALKING,
    DEAD,
}

@export var WALK_SPEED: float = 600.0

var _state: State = State.WALKING

@onready var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var floor_detector := $FloorDetector as RayCast2D
@onready var animated_sprite := $AnimatedSprite2D as AnimatedSprite2D


func _physics_process(delta: float) -> void:
    if _state == State.WALKING and velocity.is_zero_approx():
        velocity.x = WALK_SPEED
    velocity.y += gravity * delta
    if not floor_detector.is_colliding():
        velocity.x *= -1;

    if is_on_wall():
        velocity.x = -velocity.x

    move_and_slide()

    if velocity.x > 0.0:
        animated_sprite.scale.x = 0.8
    elif velocity.x < 0.0:
        animated_sprite.scale.x = -0.8

    var animation: StringName = get_animation()
    if animation != animated_sprite.animation:
        animated_sprite.play(animation)


func destroy() -> void:
    _state = State.DEAD
    velocity = Vector2.ZERO


func get_animation() -> StringName:
    var new_animation: StringName
    if _state == State.WALKING:
        new_animation = &"idle" if velocity.x == 0 else &"walk"
    else: # Death
        new_animation = &"destroy"
    return new_animation
