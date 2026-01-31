class_name BeamAttack extends RayCast2D

@export var beam_width: float = 3.0
@export var beam_color: Color = Color.GOLD

@onready var line: Line2D = $Line2D as Line2D
@onready var beam_time: Timer = $BeamTime as Timer


func _ready():
	# Ray setup
	#target_position = Vector2(max_range, 0)
	enabled = true

	# Line setup
	line.width = beam_width
	line.default_color = beam_color
	line.visible = false


func fire(amount: float):
	force_raycast_update()

	var end: Vector2 = position
	end.x += amount

	line.points = [Vector2.ZERO, Vector2(amount, 0)]
	line.visible = true
	beam_time.start()


func stop_fire():
	line.visible = false

