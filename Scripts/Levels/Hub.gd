extends Node2D

func _enter_tree() -> void:
    var player_spawn_point: Vector2 = find_child(MainManager.current_game_data.last_hub_tombstone).global_position
    var player: Node = get_node("Player")

    player.global_position = player_spawn_point
    player.get_node("Camera2D").global_position = player_spawn_point
