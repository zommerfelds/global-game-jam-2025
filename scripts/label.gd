extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = 'Karo, Chrigu, Välu, Yue and Nicku are awesome'
	set_position(Vector2(200,400))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_position(Vector2(position.x + delta*50,400))
	pass
