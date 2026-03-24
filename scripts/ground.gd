extends TileMapLayer


func _on_remove_collision_body_entered(body: Node2D) -> void:
	if body is Player:
		collision_enabled = false


func _on_remove_collision_body_exited(body: Node2D) -> void:
	if body is Player:
		collision_enabled = true
