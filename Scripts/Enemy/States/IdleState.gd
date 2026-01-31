class_name IdleState extends StateBase

@export var default_speed: float = 300

# !!! This is not idle yer

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
    # Does not perhaps need anything ?
    pass
    #
    #var animation: StringName = controller.get_animation()
    #if animation != controller.animated_sprite.animation:
    #    controller.animated_sprite.play(animation)
