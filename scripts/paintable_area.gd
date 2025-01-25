extends Sprite2D

var border_size = 10
var area_width = 500
var area_height = 300
var splash_size = 20
var background_color = Color.LAVENDER
var player_colors = [Color.HOT_PINK, Color.BLUE]
var image = Image.create(area_width, area_height, false, Image.FORMAT_RGBA8)
var preloaded_splash_values = Dictionary()

@onready var area = (area_width - 2 * border_size) * (area_height - 2 * border_size)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image.fill(Color.DARK_SLATE_BLUE)
	image.fill_rect(
		Rect2i(border_size, border_size, area_width - 2*border_size, area_height - 2*border_size),
	 	Color.LAVENDER
	)
	texture = ImageTexture.create_from_image(image)
	
	var image = Image.new()
	image.load("res://assets/splashes/splash_01_x64.png")
	for x in image.get_width():
		for y in image.get_height():
			var color = image.get_pixel(x, y)
			# Ignore fully transparent pixels.
			if color.a == 0:
				continue
				
			var offset = Vector2(
				x - (image.get_width() / 2),
				y - (image.get_height() / 2))
			preloaded_splash_values[offset] = color.a
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func splash(position: Vector2, color: Color, radius: float) -> int:
	var paint_position = position - self.position + Vector2(area_width/2, area_height/2)
	# return paint_circle(paint_position, radius, color)
	# TODO: Show sprite on top and fade it out.
	return paint_splash(paint_position, color)

func paint_splash(position: Vector2, color: Color) -> int:
	var num_pixels_painted = 0
	for offset in preloaded_splash_values.keys():
		var relative_position = position + offset
		if image.get_pixel(relative_position.x, relative_position.y) != background_color:
				# Don't paint if the pixel already has a non-background color.
			continue

		var alpha = preloaded_splash_values[offset]
		image.set_pixel(relative_position.x, relative_position.y, Color(color, alpha))
		num_pixels_painted += 1
		
	texture = ImageTexture.create_from_image(image)
	return num_pixels_painted
		
		

func paint_circle(position: Vector2, radius: float, color: Color) -> int:
	# Draw a circle, column by column
	var num_pixels_painted = 0
	for x in range(-radius, radius + 1):
		var sq = sqrt(radius**2 - x**2)
		for y in range(-sq, sq + 1):
			if image.get_pixel(position.x + x, position.y + y) != background_color:
				# Don't paint if the pixel already has a non-background color.
				continue
			image.set_pixel(position.x + x, position.y + y, color)
			num_pixels_painted += 1
	texture = ImageTexture.create_from_image(image)
	return num_pixels_painted
	
