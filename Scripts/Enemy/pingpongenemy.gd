extends Area2D

@export var max_val: Vector2 = Vector2.ZERO
@export var min_val: Vector2 = Vector2.ZERO
@export var movement_speed: float = 80
@export var damage_amount: float = 25
@export var pause_time: float = 0.3

@onready var floor_detector: RayCast2D = $FloorDetector as RayCast2D
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D

var target: Vector2
var pause_timer: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_val.y = position.y
	min_val.y = position.y
	target = max_val
	body_entered.connect(_on_body_enter)

func _physics_process(delta: float) -> void:
	if pause_timer > 0:
		pause_timer -= delta
		return

	var dir: Vector2 = (target - position)
	var dist: float = dir.length()

	if dist <= movement_speed * delta:
		position = target
		target = min_val if target == max_val else max_val
		pause_timer = pause_time
		anim_sprite.scale.x *= -1
	else:
		position += dir.normalized() * movement_speed * delta

func _on_body_enter(body: CharacterBody2D) -> void:
	# Remove from current parent before adding to inventory
	
	if body is not Player:
		return
	print("Hedgehod did damage")
	
	body.get_node("HealthNode").take_damage(damage_amount)
	
