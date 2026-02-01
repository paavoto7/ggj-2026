extends Control



func _on_start_game_pressed() -> void:
	print("BUTTON PRESSED")
	get_tree().change_scene_to_file("res://Scenes/levels/level2.tscn") # Replace with function body.

func _on_start_game_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/levels/level2.tscn")


func _on_start_game_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/levels/level3.tscn")


func _on_start_game_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/levels/level4.tscn")


func _on_start_game_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/levels/level5.tscn")
