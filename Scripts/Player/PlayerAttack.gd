class_name PlayerAttack extends Marker2D

@export var RANGE: float = 50
@export var damage_amount: int = 50
@export var ghost_mask: int = 3

@export var attack_sound: AudioStream = null

#@onready var attack_beam: Marker2D = $AttackOrigin as Marker2D
@onready var timer := $Cooldown as Timer
@onready var exclude_nodes: Array = [self.get_parent()]
@onready var beam_attack: BeamAttack = $BeamAttack as BeamAttack
@onready var attack_ray: RayCast2D = $attack_ray as RayCast2D

var beam_target: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

var origin: Vector2
var end: Vector2

# is called from player.gd
func attack(direction: float = 1.0) -> bool:
    if not timer.is_stopped():
        return false

    if attack_ray.is_colliding() and attack_ray.get_collider() is Enemy:
        var enemy: Enemy = attack_ray.get_collider()
        enemy.health.take_damage(damage_amount)
    
    AudioManager.play_sfx_2d(attack_sound, global_position)
    
    origin = global_position
    queue_redraw()
    end = origin
    end.x += direction * RANGE

    var query = PhysicsRayQueryParameters2D.create(origin, end, ghost_mask, exclude_nodes)
    var result: Dictionary = get_world_2d().direct_space_state.intersect_ray(query)
    
    beam_attack.fire(RANGE * direction)
    
    if result and result.collider:
        if result.collider is Enemy:
            var enemy_health: CharacterHealth = result.collider.get_node("HealthNode") as CharacterHealth
            if enemy_health:
                enemy_health.take_damage(damage_amount)

    timer.start()
    return true
