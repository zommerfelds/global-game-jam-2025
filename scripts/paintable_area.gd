extends Sprite2D

var border_size = 10
var area_width = 600
var area_height = 500
var splash_size = 20
var image = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image = Image.create(area_width, area_height, false, Image.FORMAT_RGBA8)
	image.fill(Color.DARK_SLATE_BLUE)
	image.fill_rect(
		Rect2i(border_size, border_size, area_width - 2*border_size, area_height - 2*border_size),
	 	Color.LAVENDER
	)
	set_position(Vector2(400, 300))
	texture = ImageTexture.create_from_image(image)
	
	# A test for painting a certain area.
	_paint_area(Vector2(200, 200), Color.HOT_PINK)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _paint_area(position: Vector2, color: Color) -> void:
	image.fill_rect(
		Rect2i(position.x, position.y, splash_size, splash_size),
		color
	)
	texture = ImageTexture.create_from_image(image)
	
