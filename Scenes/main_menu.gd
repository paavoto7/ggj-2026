extends Control

func _on_start_game_pressed() -> void:
	print("BUTTON PRESSED")
	get_tree().change_scene_to_file("res://Scenes/levels/hub.tscn") # Replace with function body.
