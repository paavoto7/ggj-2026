extends Area2D

@export var damage: int = 50
@export var kills_immediately: bool = false

@onready var collider: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
    body_entered.connect(_on_body_enter)


func _on_body_enter(body: Node2D) -> void:
    if body is Player:
        var damage_to_deal: int = body.health.MAX_HEALTH if kills_immediately else damage
        body.health.take_damage(damage_to_deal)
