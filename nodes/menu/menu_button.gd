extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_mouse_entered)


func _process(_delta: float) -> void:
	pass


func _mouse_entered():
	print("enter! " + text)
	$"../../Cannon".global_position.y = global_position.y


func _pressed():
	if text == 'Level 1':
		get_tree().change_scene_to_file("res://nodes/main_scene.tscn")
	elif text == 'Level 2':
		pass
	
