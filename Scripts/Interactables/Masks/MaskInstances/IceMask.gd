class_name IceMask extends MaskItem

var callables: Array[Callable] = []


func get_callables() -> Array[Callable]:
    return callables

var playerHealth: CharacterHealth
var oldMaxHealth: int

func set_static_effects():
    playerHealth = get_tree().get_first_node_in_group("player").get_node("HealthNode") as CharacterHealth
    oldMaxHealth = playerHealth.MAX_HEALTH
    playerHealth.MAX_HEALTH = 1
    playerHealth.health = 1
    
    print("Set static effects")

func unset_static_effects():
    playerHealth.MAX_HEALTH = oldMaxHealth
    playerHealth.health = oldMaxHealth
    print("Unset static effects")

func _ready() -> void:
    for method in get_method_list():
        if method.name.begins_with("callable"):
            callables.append(Callable(self, method.name))
