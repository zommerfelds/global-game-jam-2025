extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_focus_button)
	focus_entered.connect(_focus_button)
	
	# If this is the first button, set the focus.
	if get_parent().get_child(0) == self:
		_focus_button()


func _process(_delta: float) -> void:
	pass


func _focus_button():
	grab_focus()
	$"../../Cannon".global_position.y = global_position.y


func _pressed():
	if text == 'Level 1':
		Global.level_scene = "res://nodes/levels/level_1.tscn"
		get_tree().change_scene_to_file("res://nodes/main_scene.tscn")
	elif text == 'Level 2':
		Global.level_scene = "res://nodes/levels/level_2.tscn"
		get_tree().change_scene_to_file("res://nodes/main_scene.tscn")
	elif text == 'Exit':
		get_tree().quit()
	else:
		print("Button not recognized: " + text)
	
