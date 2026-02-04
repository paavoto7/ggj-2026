extends MenuBase

func _on_start_game_pressed():
    print("Loading hub scene")
    get_tree().change_scene_to_file("res://Scenes/levels/hub.tscn")

func _on_quit_game_pressed():
    print("Quitting game")
    get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
    get_tree().quit()
