extends Area2D

var velocity = Vector2.ZERO

func _physics_process(delta):
	position += velocity * delta
	if position.y < 0 or position.y > get_viewport().size.y or position.x < 0 or position.y > get_viewport().size.y:
		position = Vector2.ZERO
		queue_free()
