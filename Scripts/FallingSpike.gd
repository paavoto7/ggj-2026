extends Node2D

@onready var trigger_area: Area2D = $TriggerArea
@onready var damage_area: Area2D = $DamageArea

var fall_speed := 0.0
const GRAVITY := 1200.0
const MAX_FALL_SPEED := 2000.0

var falling := false
var triggered := false

func _ready():
	trigger_area.body_entered.connect(_on_trigger_entered)
	damage_area.body_entered.connect(_on_damage_body_entered)
	damage_area.monitoring = false  # don't hurt until falling

func _process(delta):
	if falling:
		fall_speed = min(fall_speed + GRAVITY * delta, MAX_FALL_SPEED)
		position.y += fall_speed * delta

func _on_trigger_entered(body):
	if triggered:
		return
		
	if body.is_in_group("player"):
		triggered = true
		start_fall_delay()

func start_fall_delay():
	await get_tree().create_timer(1.0).timeout
	falling = true
	damage_area.monitoring = true  # NOW it can deal damage

func _on_damage_body_entered(body):
	var health_node = body.get_node_or_null("HealthNode")
	if health_node and health_node.has_method("take_damage"):
		print("The player took damage")
		health_node.take_damage(25)

	  # remove spike after hit
		queue_free()
