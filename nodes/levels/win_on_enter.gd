extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if "player_id" in body:
		Global.throphy_collected.emit(body.player_id)
