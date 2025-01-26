extends Node

var cannon: Sprite2D
var enabled: bool = false
const AIM_TIME: float = 1.0

var state = "aiming"

var still_to_shoot: float = 0.0
var target_angle_degrees: float = 45.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not cannon or not enabled:
		return
	if state == "aiming":
		if cannon.rotation_degrees > target_angle_degrees + 2:
			cannon.rotate_down(delta)
		elif cannon.rotation_degrees < target_angle_degrees - 2:
			cannon.rotate_up(delta)
		else:
			state = "shooting"
			still_to_shoot = 0.25 + randf()
			cannon.shoot_press()
	elif state == "shooting":
		still_to_shoot -= delta
		cannon.shoot_hold(delta)
		if still_to_shoot <= 0:
			cannon.shoot_release()
			state = "aiming"
			target_angle_degrees = 30 + randf()*30
			
