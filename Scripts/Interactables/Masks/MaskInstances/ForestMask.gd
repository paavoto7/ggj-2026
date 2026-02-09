class_name ForestMask extends MaskItem

func _ready() -> void:
    super._ready()
    mask_id = "forest_mask"
    mask_anim_id = "m2_"

const time_scale_factor: int =  2

func set_static_effects():
    Engine.time_scale *= time_scale_factor
    print("Set static effects")

func unset_static_effects():
    Engine.time_scale /= time_scale_factor
    print("Unset static effects")

