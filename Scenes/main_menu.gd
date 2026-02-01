extends Control

func _on_start_game_pressed():
	print("BUTTON PRESSED")
	get_tree().change_scene_to_file("res://Scenes/levels/hub.tscn")
