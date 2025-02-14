extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_focus_button)
	focus_entered.connect(_focus_button)
	
	# If this is the first button, set the focus.
	if get_parent().get_child(0) == self:
		_focus_button()
		
	if text == "Co-op mode":
		button_pressed = Global.coopMode


func _process(_delta: float) -> void:
	pass


func _focus_button():
	grab_focus()
	$"../../Cannon".global_position.y = global_position.y


func _pressed():
	if name.begins_with("Level"):
		await $"../../Colorizer".spawn_splashes(100)
		Global.start_level(name)
	elif text == 'Exit':
		await $"../../Colorizer".spawn_splashes(100)
		get_tree().quit()
	elif text == "Co-op mode":
		Global.coopMode = !Global.coopMode
	elif name == "AIEnabled":
		Global.ai_enabled = self.button_pressed
	elif name == "MusicEnabled":
		if self.button_pressed:
			Global.next_soundtrack()
		Global.soundtrack.playing = self.button_pressed
	else:
		print("Button not recognized: " + text)
	
