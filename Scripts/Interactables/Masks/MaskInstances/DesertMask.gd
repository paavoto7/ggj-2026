class_name DesertMask extends MaskItem

# Time of the speedrun in seconds
@export var speedrun_time: int = 300

func _ready() -> void:
    super._ready()
    mask_id = "desert_mask"
    mask_anim_id = "m3_"

func set_static_effects():
    _start_update_timer()

func unset_static_effects():
    _stop_update_timer()

var has_double_jumped: bool = false

func callable_double_jump(player: Player) -> void:
    if Input.is_action_just_pressed("jump") and player.jump_timer.is_stopped() and !has_double_jumped:
        has_double_jumped = true
        player.velocity.y = player.jump_velocity
    elif player.is_on_floor() and has_double_jumped:
        has_double_jumped = false


# These below take care of the speedrun timer

var timer_label: Label
var should_stop: bool = false

func _start_update_timer() -> void:
    var player: Player = get_tree().get_first_node_in_group("player") as Player
    timer_label = player.get_node("HUD/Control/SpeedrunTimer/Label") as Label
    timer_label.get_parent().visible = true
    
    var remaining: int = speedrun_time
    while remaining > 0 && !should_stop:
        timer_label.text = var_to_str(remaining)
        remaining -= 1
        await get_tree().create_timer(1.0).timeout
    
    # Not ideal, but works
    player.health.take_damage(player.health.MAX_HEALTH)
    

func _stop_update_timer() -> void:
    timer_label.visible = false
    should_stop = true
