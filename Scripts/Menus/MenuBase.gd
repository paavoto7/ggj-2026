class_name MenuBase extends CanvasLayer

# Is a base class for menu items

func _enter_tree() -> void:
	# Ready was too late
	self.visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	# Hides cursor when in gameplay view
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if self.visible else Input.MOUSE_MODE_HIDDEN
