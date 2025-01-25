extends Node2D

var button_width = 20
var button_height = 15
var selected_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GridContainer/BlueButton.set_pressed_no_signal(true)
	$GridContainer/BlueButton.text = "BLUE"
	$GridContainer/GreenButton.text = "GREEN"
	$GridContainer/RedButton.text = "RED"
	for button in $GridContainer.get_children():
		button.set_size(Vector2(button_width, button_height))
		button.pressed.connect(func(): _button_pressed(button))

func _button_pressed(pressed: Button):
	if selected_button != null:
		selected_button.set_pressed_no_signal(false)
	selected_button = pressed
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
