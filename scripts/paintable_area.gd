extends Sprite2D

var border_size = 10
var area_width = 500
var area_height = 300
var splash_size = 20
var background_color = Color.LAVENDER
var player_colors = [Color.HOT_PINK, Color.BLUE]
var image = Image.create(area_width, area_height, false, Image.FORMAT_RGBA8)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image.fill(Color.DARK_SLATE_BLUE)
	image.fill_rect(
		Rect2i(border_size, border_size, area_width - 2*border_size, area_height - 2*border_size),
	 	Color.LAVENDER
	)
	texture = ImageTexture.create_from_image(image)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func splash(position: Vector2, color: Color, radius: float):
	var paint_position = position - self.position + Vector2(area_width/2, area_height/2)
	paint_circle(paint_position, radius, color)
	# TODO: Show sprite on top and fade it out.


func paint_circle(position: Vector2, radius: float, color: Color) -> void:
	# Draw a circle, column by column
	for x in range(-radius, radius + 1):
		var sq = sqrt(radius**2 - x**2)
		for y in range(-sq, sq + 1):
			if image.get_pixel(position.x + x, position.y + y) != background_color:
				# Don't paint if the pixel already has a non-background color.
				continue
			image.set_pixel(position.x + x, position.y + y, color)
	texture = ImageTexture.create_from_image(image)
	
