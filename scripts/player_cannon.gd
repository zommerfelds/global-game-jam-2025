class_name Player_Cannon extends Sprite2D

signal bubble_fired(player_id, duration)

@export var player_id = 0

const ROTATION_SPEED = 50.0
const SHAKE_MAGNITUDE = 10
const SHAKE_FREQUENCY = 100  # .. divided by 2pi

# Angle of 0 means horizontal, 90 means vertical
var angle = 0.0
var fire_duration = 0.0
var elapsed_time = 0.0
@onready var initial_position = position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	var mirror = 1 if player_id == 1 else -1
	var x_offset = mirror * (sin(elapsed_time) * 100 + 100)
	position.x = initial_position.x + x_offset
	if Input.is_action_pressed("rotate_cw_player_" + str(player_id)):
		rotate_cannon(delta * ROTATION_SPEED * mirror)
	elif Input.is_action_pressed("rotate_ccw_player_" + str(player_id)):
		rotate_cannon(-delta * ROTATION_SPEED * mirror)

	if Input.is_action_just_pressed("shoot_player_" + str(player_id)):
		fire_duration = 0.0
		$Wubwub.play()
		$Wubwub.volume_db = fire_duration*10
		$Wubwub.pitch_scale = 1.0
	if Input.is_action_pressed("shoot_player_" + str(player_id)):
		fire_duration += delta
		$Wubwub.volume_db = fire_duration*10
		$Wubwub.pitch_scale = (1.0 + clamp(fire_duration/2, 0, 1))
		offset = Vector2(0, 45) + SHAKE_MAGNITUDE*fire_duration * Vector2(sin(SHAKE_FREQUENCY*fire_duration), cos(SHAKE_FREQUENCY*1.1*fire_duration))
	if Input.is_action_just_released("shoot_player_" + str(player_id)):
		bubble_fired.emit(player_id, fire_duration)
		# This is the initial value from the UI
		offset = Vector2(0, 45)
		$Wubwub.stop()


func rotate_cannon(rotation_angle_change: float) -> void:
	angle = clamp(angle + rotation_angle_change, -120, 0)
	rotation_degrees = angle if player_id == 1 else -angle
