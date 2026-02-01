class_name ForestMask extends MaskItem

var callables: Array[Callable] = []

const time_scale_factor: int =  2


func get_callables() -> Array[Callable]:
    return callables

func set_static_effects():
    Engine.time_scale *= time_scale_factor
    print("Set static effects")

func unset_static_effects():
    Engine.time_scale /= time_scale_factor
    print("Unset static effects")

func _ready() -> void:
    for method in get_method_list():
        if method.name.begins_with("callable"):
            callables.append(Callable(self, method.name))
