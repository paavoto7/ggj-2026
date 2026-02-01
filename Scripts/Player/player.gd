class_name Player extends CharacterBody2D

@export var speed: float = 300
@export var jump_velocity: float = -460.0

@export var coyote_time: float = 0.1
@export var jump_buffer_time: float = 0.1

@onready var steps_sound: AudioStreamPlayer2D = $StepSounds

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var attack_handler: PlayerAttack = $AttackOrigin as PlayerAttack

@onready var inventory: Inventory = $Inventory as Inventory

@onready var jump_timer: Timer = $JumpTimer as Timer

var direction: float = 0

enum Direction { Left = -1, Right = 1 } # Not ideal...
var dir_sign: Direction = Direction.Right
var is_shooting: bool = false

var anim_playing: bool = false

var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0

var should_update: bool = true

func _physics_process(delta: float) -> void:
    if Input.is_action_just_pressed("pause_menu"):
        $"GameOver".game_over()
    
    if !should_update:
        return
        
    anim_playing = false
    
    coyote_timer -= delta
    jump_buffer_timer -= delta

    if is_on_floor():
        coyote_timer = coyote_time

    
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    # Handle jump.
    if Input.is_action_just_pressed("jump"):
        jump_buffer_timer = jump_buffer_time

        if is_on_floor():
            velocity.y = jump_velocity
            if direction < 0:
                _play_anim("jump_left")
            else:
                _play_anim("jump_right")
            jump_timer.start()
            
        if jump_buffer_timer > 0 and coyote_timer > 0 and not is_on_floor():
            velocity.y = jump_velocity
            jump_buffer_timer = 0
            coyote_timer = 0
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
        if !steps_sound.playing:
            steps_sound.play()

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
        attack_handler.attack(dir_sign)

    if is_on_floor() and direction == 0:
        if dir_sign == Direction.Left:
            _play_anim("idle_left")
        else:
            _play_anim("idle_right")
    
    if Input.is_action_just_pressed("attack"):
        attack_handler.attack(dir_sign)
    
    _apply_callables()
    
    move_and_slide()

func _play_anim(anim_name: StringName) -> void:
    if !anim_playing:
        animated_sprite.play(anim_name)
        anim_playing = true

func _apply_callables() -> void:
    if not inventory.currentMask:
        return

    for callable in inventory.currentMask.get_callables():
        callable.call(self)
