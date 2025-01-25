extends Area2D

signal bubble_burst()

var velocity = Vector2.ZERO
var player_id: int
var splash_radius: float = 50
var color: Color
var duration: float


func _ready():
	$Sprite.set_modulate(color)
	$Sprite.material.set_shader_parameter("seed", randf()*10)

func _physics_process(delta):
	position += velocity * delta
	
	if position.y < 0 or position.y > get_viewport().size.y or position.x < 0 or position.y > get_viewport().size.y:
		position = Vector2.ZERO
		queue_free()
		
	duration -= delta

	if duration < 0.0:
		velocity = Vector2.ZERO
		#$Sprite.texture = preload("res://assets/splash.png")
		bubble_burst.emit(position, player_id, splash_radius)
		queue_free()
