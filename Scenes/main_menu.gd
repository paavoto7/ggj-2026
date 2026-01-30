extends Control



func _on_start_game_pressed() -> void:
	print("BUTTON PRESSED")
	var result = get_tree().change_scene_to_file("res://Scenes/levels/level1.tscn") # Replace with function body.
	print("Result: ", result)
