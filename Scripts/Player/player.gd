class_name Player extends CharacterBody2D

@export var speed: float = 300
@export var jump_velocity: float = -460.0

@export var coyote_time: float = 0.1
@export var jump_buffer_time: float = 0.1

@onready var steps_sound: AudioStreamPlayer2D = $StepSounds

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var attack_handler: PlayerAttack = $AttackOrigin as PlayerAttack

@onready var inventory: Inventory = $Inventory as Inventory
@onready var health: CharacterHealth = $HealthNode as CharacterHealth

@onready var jump_timer: Timer = $JumpTimer as Timer

var direction: float = 0

enum Direction { Left = -1, Right = 1 } # Not ideal...
var dir_sign: Direction = Direction.Right
var is_shooting: bool = false

var anim_playing: bool = false

var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0

var should_update: bool = true

func _ready() -> void:
    health.character_died.connect(_handle_death)

func _physics_process(delta: float) -> void:
    if Input.is_action_just_pressed("pause_menu"):
        $"GameOver".game_over()
        return
    
    if !should_update:
        return
        
    anim_playing = false

    # Query for jump and jump if pressed    
    _handle_jump(delta)

    # Get the input direction and handle the movement/deceleration.
    _handle_movement()

    if is_on_floor() and direction == 0:
        if dir_sign == Direction.Left:
            _play_anim("idle_left")
        else:
            _play_anim("idle_right")
    
    if Input.is_action_just_pressed("attack"):
        attack_handler.attack(dir_sign)
    
    _apply_callables()
    
    move_and_slide()


func _handle_movement() -> void:
    direction = Input.get_axis("move_left", "move_right")

    velocity.x = direction * speed if direction else move_toward(velocity.x, 0, speed)
    
    if !steps_sound.playing:
        steps_sound.play()
    
    if velocity:
        if direction * dir_sign < 0:
            attack_handler.position.x *= -1
        
        if direction < 0:
            _play_anim("walk_left")
            dir_sign = Direction.Left
            
        else:
            _play_anim("walk_right")
            dir_sign = Direction.Right


func _handle_jump(delta: float) -> void:
    coyote_timer -= delta
    jump_buffer_timer -= delta

    var on_floor: bool = is_on_floor()
    
    # Add the gravity.
    if not on_floor:
        velocity += get_gravity() * delta
    else:
        coyote_timer = coyote_time

    # Handle jump.
    if Input.is_action_just_pressed("jump"):
        jump_buffer_timer = jump_buffer_time

        if on_floor:
            _jump()
            
        elif jump_buffer_timer > 0 and coyote_timer > 0:
            jump_buffer_timer = 0
            coyote_timer = 0
            _jump()


# Do the actual jump
func _jump() -> void:
    velocity.y = jump_velocity
    if direction < 0:
        _play_anim("jump_left")
    else:
        _play_anim("jump_right")
    jump_timer.start()


func _play_anim(anim_name: StringName) -> void:
    if anim_playing:
        return
    
    if inventory.currentMask:
        anim_name = inventory.currentMask.mask_anim_id + anim_name
    
    if animated_sprite.animation != anim_name:
        animated_sprite.play(anim_name)
        anim_playing = true

func _apply_callables() -> void:
    if not inventory.currentMask:
        return

    for callable in inventory.currentMask.get_callables():
        callable.call(self)

func _handle_death():
    should_update = false
    $GameOver.game_over()
