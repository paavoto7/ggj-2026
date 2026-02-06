class_name WorldMask extends Interactable

@export var mask_pickup_sound: AudioStream = preload("res://Assets/Audio/MaskPickUpS.wav")

@onready var mask_item: MaskItem = $MaskItem as MaskItem


func interact(player: Player) -> void:
    # Remove from current parent before adding to inventory
    mask_item.get_parent().remove_child(mask_item)

    # Add to player's inventory
    player.inventory.add_child(mask_item)
    player.inventory.add_item(mask_item)
    player.inventory.apply_mask(mask_item)

    AudioManager.play_sfx_2d(mask_pickup_sound, global_position)

    queue_free()
