class_name Player_Cannon extends Sprite2D

signal bubble_fired(player_id)

@export var player_id = 0

const ROTATION_SPEED = 50.0

# Angle of 0 means horizontal, 90 means vertical
var angle = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mirror = 1 if player_id == 1 else -1
	if Input.is_action_pressed("rotate_cw_player_" + str(player_id)):
		rotate_cannon(delta * ROTATION_SPEED * mirror)
	elif Input.is_action_pressed("rotate_ccw_player_" + str(player_id)):
		rotate_cannon(-delta * ROTATION_SPEED * mirror)

	if Input.is_action_just_pressed("shoot_player_" + str(player_id)):
		bubble_fired.emit(player_id)

func rotate_cannon(rotation_angle_change: float) -> void:
	angle = clamp(angle + rotation_angle_change, -90, 0)
	rotation_degrees = angle if player_id == 1 else -angle
