extends CharacterBody2D

@export var speed: float = 120.0
@export var pause_time: float = 0.3

@onready var start: Marker2D = $Start
@onready var end: Marker2D = $End

var target: Vector2
var pause_timer: float = 0.0

func _ready() -> void:
	position = start.global_position
	target = end.global_position

func _physics_process(delta: float) -> void:
	if pause_timer > 0:
		pause_timer -= delta
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var dir: Vector2 = target - position
	var dist: float = dir.length()

	if dist <= speed * delta:
		position = target
		target = start.global_position if target == end.global_position else end.global_position
		pause_timer = pause_time
		velocity = Vector2.ZERO
	else:
		velocity = dir.normalized() * speed

	move_and_slide()
