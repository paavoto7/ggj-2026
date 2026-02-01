extends CanvasLayer

func _ready():
	self.hide()

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
	
func game_over():
	self.show()
 # Replace with function body.
