class_name Player extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_velocity: float = -800.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var attack_handler: PlayerAttack = $AttackOrigin as PlayerAttack
@onready var attack_ray: RayCast2D = $attack_ray as RayCast2D

@onready var inventory: Inventory = $Inventory as Inventory

@onready var jump_timer: Timer = $JumpTimer as Timer

var direction: float = 0

enum Direction { Left = -1, Right = 1 } # Not ideal...
var dir_sign: Direction = Direction.Right
var is_shooting: bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

    # Handle jump.
    if is_on_floor() and Input.is_action_just_pressed("jump"):
        velocity.y = jump_velocity
        if direction < 0:
            _play_anim("jump_left")
        else:
            _play_anim("jump_right")
        jump_timer.start()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed

		if direction < 0:
			_play_anim("walk_left")
			dir_sign = Direction.Left
			if attack_handler.position.x > 0:
				attack_handler.position.x *= -1
		else:
			_play_anim("walk_right")
			dir_sign = Direction.Right
			if attack_handler.position.x < 0:
				attack_handler.position.x *= -1
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

    if Input.is_action_just_pressed("attack"):
        if attack_ray.is_colliding() and not attack_ray.get_collider() is Enemy:
            var enemy: Enemy = attack_ray.get_collider()
            enemy.health.take_damage(50.0)
        attack_handler.attack(dir_sign)
    
    move_and_slide()

func _play_anim(anim_name: StringName) -> void:
    animated_sprite.play(anim_name)
