class_name AttackState extends StateBase

@export var default_speed: float = 300

var controller: Enemy = null
var player: Player = null
var player_health: CharacterHealth = null
var elapsed_attack: float = 0

func _init(e: Enemy, p: Player) -> void:
    controller = e
    player = p
    player_health = player.get_node("HealthNode")


# Called when entering the state
func on_enter():
    pass

# Called when exiting the state
func on_exit(next_state: StateBase):
    pass

const prox_threshold: int = 400

# Called every frame while in this state
func on_update(delta: float):
    if not player:
        return
        
    var distance_to_player: float = _can_attack()
    
    var direction: Vector2 = (player.global_position - controller.global_position).normalized()
    controller.velocity = direction * controller.CHASE_SPEED

    if distance_to_player < prox_threshold:
        controller.velocity *= distance_to_player / prox_threshold

    if controller.is_on_wall():
        controller.velocity.x = -controller.velocity.x

    controller.move_and_slide()

    if controller.velocity:
        controller.animated_sprite.scale.x = sign(controller.velocity.x) * 0.8

    var animation: StringName = controller.get_animation()
    if animation != controller.animated_sprite.animation:
        controller.animated_sprite.play(animation)
    
    if player_health and distance_to_player < controller.attack_distance and controller.attack_speed < elapsed_attack:
        # Audiomanaget play
        player_health.take_damage(controller.damage_amount)
        elapsed_attack = 0
    
    elapsed_attack += delta

func _can_attack() -> float:
    return controller.global_position.distance_to(player.global_position)
