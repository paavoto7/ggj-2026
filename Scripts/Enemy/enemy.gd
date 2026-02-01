class_name Enemy extends CharacterBody2D

enum State {
	IDLE,
	DEAD,
}

@export var WALK_SPEED: float = 400.0
@export var CHASE_SPEED: float = 800.0

@export var damage_amount: float = 25
@export var attack_distance: float = 200
@export var attack_speed: float = 2

var state_machine: StateMachine

@onready var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var floor_detector := $FloorDetector as RayCast2D
@onready var animated_sprite := $AnimatedSprite2D as AnimatedSprite2D

@onready var health: CharacterHealth = $HealthNode

var player: Player

func _ready() -> void:
	var idle: StateBase = IdleState.new(self)
	player = get_tree().get_first_node_in_group("player")
	var attack: StateBase = AttackState.new(self, player)
	state_machine = StateMachine.new()
	state_machine.initialize_with_state(idle)
	state_machine.add_state(attack)

func _physics_process(delta: float) -> void:
	state_machine.update(delta)


# Not used
func destroy() -> void:
	#_state = State.DEAD
	velocity = Vector2.ZERO


func get_animation() -> StringName:
	var new_animation: StringName
	if state_machine.current_state == IdleState:
		new_animation = &"idle"
	elif state_machine.current_state != null:
		new_animation = &"walk"
	else: # Death
		new_animation = &"destroy"
	return new_animation
