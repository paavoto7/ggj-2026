class_name LavaMask extends MaskItem

func _ready() -> void:
    super._ready()
    mask_id = "lava_mask"
    mask_anim_id = "m4_"

func set_static_effects():
    # Should make screen dark and invert controls
    pass

func unset_static_effects():
    pass

