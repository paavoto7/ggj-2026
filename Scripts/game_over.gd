extends CanvasLayer

func _ready():
    self.hide()

func _on_retry_pressed() -> void:
    get_tree().reload_current_scene()
    
func _on_back_to_menu_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/main.tscn")
    
func _on_hub_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/levels/hub.tscn")
    
func game_over():
    self.show()

