class_name MaskItem extends Node

var callables: Array[Callable] = []

func get_callables() -> Array[Callable]:
    return callables

# Should add the callables from children to the array
func _ready() -> void:
    for method in get_method_list():
        if method.name.begins_with("callable"):
            callables.append(Callable(self, method.name))

# These are for static effect like time boost or colour change etc.
func set_static_effects(): pass

func unset_static_effects(): pass
