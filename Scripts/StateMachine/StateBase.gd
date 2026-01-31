class_name StateBase

# Called when entering the state
func on_enter():
    pass

# Called when exiting the state
func on_exit(next_state: StateBase):
    pass

# Called every frame while in this state
func on_update(delta: float):
    pass
