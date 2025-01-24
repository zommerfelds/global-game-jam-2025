class_name Player_Cannon extends Sprite2D

const ROTATION_SPEED = 50.0

# Angle of 0 means horizontal, 90 means vertical
var angle = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("rotate_cw_player_1"):
		rotate_cannon(delta * ROTATION_SPEED)
	elif Input.is_action_pressed("rotate_ccw_player_1"):
		rotate_cannon(-delta * ROTATION_SPEED)
	elif Input.is_action_pressed("shoot_player_1"):
		fire_bubble()

func rotate_cannon(rotation_angle_change: float) -> void:
	angle = clamp(angle + rotation_angle_change, -90, 0)
	rotation_degrees = angle
	
func fire_bubble():
	pass
