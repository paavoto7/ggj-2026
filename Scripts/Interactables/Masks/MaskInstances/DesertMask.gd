class_name DesertMask extends MaskItem

func _ready() -> void:
    super._ready()
    mask_id = "desert_mask"
    mask_anim_id = "m3_"

func set_static_effects():
    print("Set static effects")

func unset_static_effects():
    print("Unset static effects")

var has_double_jumped: bool = false

func callable_double_jump(player: Player) -> void:
    if Input.is_action_just_pressed("jump") and player.jump_timer.is_stopped() and !has_double_jumped:
        has_double_jumped = true
        player.velocity.y = player.jump_velocity
    elif player.is_on_floor() and has_double_jumped:
        has_double_jumped = false
