extends Interactable

func interact(player: Player) -> void:
    var current_mask: MaskItem = player.get_node_or_null("Inventory/MaskItem") as MaskItem
    if current_mask:
        MainManager.current_game_data.collected_masks[current_mask.mask_id] = true

    get_tree().change_scene_to_file.call_deferred("res://Scenes/levels/hub.tscn")
