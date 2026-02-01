class_name WorldMask extends Area2D

@export var max_val: float = .25
@export var min_val: float = -.25
@export var hover_speed: float = 2

@export var mask_pickup_sound: AudioStream = preload("res://Assets/Audio/MaskPickUpS.wav")

@onready var mask_item: MaskItem = $MaskItem as MaskItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:  
	add_to_group("interactables")
	pass # Replace with function body.

var elapsed_time: float = 0
func _physics_process(delta: float) -> void:
	elapsed_time += delta * hover_speed
	var t = (sin(elapsed_time) + 1.0) * 0.5 # converts -1..1 → 0..1
	var value = lerp(min_val, max_val, t)
	position.y += value


func interact(player: Player) -> void:
	# Remove from current parent before adding to inventory
	mask_item.get_parent().remove_child(mask_item)

	# Add to player's inventory
	player.inventory.add_item(mask_item)
	player.inventory.apply_mask(mask_item)
	player.inventory.add_child(mask_item)

	AudioManager.play_sfx_2d(mask_pickup_sound, global_position)

	print("Interacted")
	queue_free()
