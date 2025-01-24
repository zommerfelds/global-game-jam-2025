extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var border_size = 10
	var area_width = 600
	var area_height = 500
	var image = Image.create(area_width, area_height, false, Image.FORMAT_RGBA8)
	image.fill(Color.DARK_SLATE_BLUE)
	image.fill_rect(
		Rect2i(border_size, border_size, area_width - 2*border_size, area_height - 2*border_size),
	 	Color.LAVENDER)
	set_position(Vector2(400, 300))
	texture = ImageTexture.create_from_image(image)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
