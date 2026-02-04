extends Interactable


func interact(_player: Player) -> void:
    get_tree().change_scene_to_file.call_deferred("res://Scenes/levels/hub.tscn")
