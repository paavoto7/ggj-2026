class_name RoamState extends StateBase

@export var default_speed: float = 300

var controller: Enemy = null

func _init(e: Enemy) -> void:
    controller = e

# Called when entering the state
func on_enter():
    pass

# Called when exiting the state
func on_exit(next_state: StateBase):
    pass

# Called every frame while in this state
func on_update(delta: float):
    if controller.velocity.is_zero_approx():
        controller.velocity.x = controller.WALK_SPEED
    controller.velocity.y += controller.gravity * delta
    
    if not controller.floor_detector.is_colliding():
        controller.velocity.x *= -1;

    if controller.is_on_wall():
        controller.velocity.x = -controller.velocity.x

    controller.move_and_slide()

    if controller.velocity.x > 0.0:
        controller.animated_sprite.scale.x = 0.8
    elif controller.velocity.x < 0.0:
        controller.animated_sprite.scale.x = -0.8

    var animation: StringName = controller.get_animation()
    if animation != controller.animated_sprite.animation:
        controller.animated_sprite.play(animation)
