extends RigidBody2D

signal bubble_burst()

var player_id: int
var splash_radius: float = 50
var color: Color
var duration: float
var cat_mode: bool = false

var extra_force: float = 0.0

func _enter_tree() -> void:
	$Sprite.material.set_shader_parameter("seed", randf()*10)
	$Sprite.material.set_shader_parameter("color_tint", color)
	if cat_mode:
		$Sprite.texture = preload("res://assets/cat-small.png")
		if player_id == 2:
			$Sprite.scale.x = -$Sprite.scale.x

func _physics_process(delta):
	if extra_force > 0:
		constant_force.y = -1000
		duration += delta/2
		extra_force -= delta
	if extra_force < 0:
		extra_force = 0
	if Input.is_action_pressed('boost_player_' + str(player_id)):
		#apply_central_force(Vector2(0, -2000))
		duration += delta #* 0.5
	elif Input.is_action_just_released('boost_player_' + str(player_id)):
		# Explode immediately!
		duration = 0
		
	duration -= delta

	if duration < 0.0:
		bubble_burst.emit(position, player_id, splash_radius)
		queue_free()

func on_blow(power: float):
	extra_force = 0.3*power
