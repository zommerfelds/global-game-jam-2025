extends Area2D

signal bubble_burst()

var velocity = Vector2.ZERO
var color: Color
var splash_radius: float = 50
var burst = false

func _physics_process(delta):
	if burst: return
	position += velocity * delta
	
	if position.y < 0 or position.y > get_viewport().size.y or position.x < 0 or position.y > get_viewport().size.y:
		position = Vector2.ZERO
		queue_free()

	if randi() % 100 == 1:
		velocity = Vector2.ZERO
		z_index = 0
		#$Sprite.texture = preload("res://assets/splash.png")
		bubble_burst.emit(position, color, splash_radius)
		burst = true
