class_name Mask extends Area2D

@onready var mask_item: MaskItem = $MaskItem as MaskItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:  
    add_to_group("interactables")
    pass # Replace with function body.

func interact(player: Player) -> void:
    # Remove from current parent before adding to inventory
    mask_item.get_parent().remove_child(mask_item)

    # Add to player's inventory
    player.inventory.add_item(mask_item)
    player.inventory.apply_mask(mask_item)
    player.inventory.add_child(mask_item)

    print("Interacted")
    queue_free()
