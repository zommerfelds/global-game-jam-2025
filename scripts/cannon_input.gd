extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var rotation_speed = 2.0
	if Input.is_action_pressed("rotate_cw_player_1"):
		rotate(delta * rotation_speed)
	elif Input.is_action_pressed("rotate_ccw_player_1"):
		rotate(-delta * rotation_speed)
	elif Input.is_action_pressed("shoot_player_1"):
		translate(Vector2(10, 0))
