class_name IceMask extends MaskItem

var playerHealth: CharacterHealth
var oldMaxHealth: int

func set_static_effects():
    playerHealth = get_tree().get_first_node_in_group("player").get_node("HealthNode") as CharacterHealth
    oldMaxHealth = playerHealth.MAX_HEALTH

    playerHealth.MAX_HEALTH = 1
    playerHealth.take_damage(playerHealth.health - 1)
    
    print("Set static effects")

func unset_static_effects():
    playerHealth.MAX_HEALTH = oldMaxHealth
    playerHealth.give_health(oldMaxHealth)
    print("Unset static effects")

