class_name IdleState extends StateBase

@export var default_speed: float = 300

# Called when entering the state
func on_enter():
    pass

# Called when exiting the state
func on_exit(next_state: StateBase):
    pass

# Called every frame while in this state
func on_update(delta: float):
    if direction:
        velocity.x = direction * speed
    else:
        velocity.x = move_toward(velocity.x, 0, speed)

    move_and_slide()
