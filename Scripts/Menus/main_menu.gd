extends MenuBase

func _on_start_game_pressed():
    print("Loading hub scene")
    get_tree().change_scene_to_file("res://Scenes/levels/hub.tscn")
