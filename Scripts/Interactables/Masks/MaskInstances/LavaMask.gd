class_name LavaMask extends MaskItem

@export var colour: Color = Color.BLACK
@export var alpha: float = 0.5

func _ready() -> void:
    super._ready()
    mask_id = "lava_mask"
    mask_anim_id = "m4_"

var player: Player
var cl: CanvasLayer

func set_static_effects():
    player = get_tree().get_first_node_in_group("player") as Player
    player.movement_modifier = -1

    cl = CanvasLayer.new()
    var cr: ColorRect = ColorRect.new()
    cl.add_child(cr)

    cr.color = colour
    cr.color.a = alpha
    cr.z_index = 100
    cr.set_anchors_preset(Control.PRESET_FULL_RECT)

    add_child(cl)
    

func unset_static_effects():
    player.movement_modifier = 1
    cl.queue_free()
