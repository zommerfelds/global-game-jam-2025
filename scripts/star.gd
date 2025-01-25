extends Area2D

signal star_collected(player_id: int)

func _on_body_entered(body: Node2D) -> void:
	if "player_id" in body:
		star_collected.emit(body.player_id)
		$Chaching.play()
		$CollisionShape2D.queue_free()
		$Sprite2D.visible = false
		await $Chaching.finished
		queue_free()
