extends Area2D

@onready var player: Player = self.get_parent() as Player

@onready var hud: HUD = $"../HUD" as HUD

@export var pos_offset: Vector2 = Vector2(0, -100)

var interactables_in_range: Array = []


func _ready() -> void:
    # When an interactable comes to the detection area, add it to the array
    area_entered.connect(_on_area_entered)
    area_exited.connect(_on_area_exited)


func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("interactables"):
        interactables_in_range.append(area)
        _update_interaction_prompt()


func _on_area_exited(area: Area2D) -> void:
    if area in interactables_in_range:
        interactables_in_range.erase(area)
        _update_interaction_prompt()


func _update_interaction_prompt() -> void:
    if !interactables_in_range.is_empty():
        var interactable: Area2D = interactables_in_range[_get_closest_interactable()]
        # Sets the pos to screen space location plus the specified offset
        hud.toggle_interaction_prompt(true, interactable.get_screen_transform().origin + pos_offset)
    else:
        hud.toggle_interaction_prompt(false)


# Not ideal in any way, but works for now
func _unhandled_input(event: InputEvent) -> void:
    if not event.is_action_pressed("interact") or interactables_in_range.is_empty():
        return
    
    var interactable: Area2D = interactables_in_range[_get_closest_interactable()]
    
    if interactable and interactable.has_method("interact"):
        interactable.interact(player)
        _on_area_exited(interactable) # Could make a dedicated method


# Returns the index of the closest interactable, or -1
func _get_closest_interactable() -> int:
    var closest: int = -1
    var distance: float = INF

    for ind in interactables_in_range.size():
        var area: Area2D = interactables_in_range[ind]
        var d: float = global_position.distance_to(area.global_position)
        if d < distance:
            closest = ind
    
    return closest
