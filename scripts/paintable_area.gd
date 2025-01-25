extends Sprite2D

var border_size = 10
var area_width = 710
var area_height = 280
var splash_size = 20
var background_color = Color.LAVENDER
var player_colors = [Color.HOT_PINK, Color.BLUE]
var image = Image.create(area_width, area_height, false, Image.FORMAT_RGBA8)
var splash_images = Array()

@onready var area = (area_width - 2 * border_size) * (area_height - 2 * border_size)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image = texture.get_image()
	background_color = image.get_pixel(100, 100)
	area_width = texture.get_size().x
	area_height = texture.get_size().y
	#image.fill(Color.DARK_SLATE_BLUE)
	#image.fill_rect(
	#	Rect2i(border_size, border_size, area_width - 2*border_size, area_height - 2*border_size),
	# 	Color.LAVENDER
	#)
	texture = ImageTexture.create_from_image(image)
	splash_images = [
		Image.load_from_file("res://assets/splashes/splash_01_x64.png"),
		Image.load_from_file("res://assets/splashes/splash_02_x64.png"),
		Image.load_from_file("res://assets/splashes/splash_03_x64.png")
	]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func splash(position: Vector2, color: Color, radius: float) -> int:
	var paint_position = position - self.position + Vector2(area_width/2, area_height/2)
	return paint_splash(paint_position, color)

func paint_splash(position: Vector2, color: Color) -> int:
	var num_pixels_painted = 0
	var splash_image = splash_images.pick_random()
	var splash_width = splash_image.get_width()
	var splash_height = splash_image.get_height()
	var offset = Vector2i(
		- (splash_width / 2),
		- (splash_height / 2))
	var splash_rotation = randf() * PI * 2
	for x in range(splash_width):
		for y in range(splash_height):
			var relative_position = Vector2i(x, y) + Vector2i(position) + offset
			# Don't paint if the pixel already has a non-background color.
			if (is_out_of_bounds(relative_position.x, relative_position.y, image) 
					or image.get_pixel(relative_position.x, relative_position.y) != background_color):
				continue
			var offset_vector = Vector2(x, y) - splash_image.get_size()/2.0
			var new_source_coords = offset_vector.rotated(splash_rotation) + splash_image.get_size()/2.0
			if (is_out_of_bounds(new_source_coords.x, new_source_coords.y, splash_image)):
				continue
			var alpha = splash_image.get_pixel(new_source_coords.x, new_source_coords.y).a
			if (alpha == 0):
				continue
			image.set_pixel(relative_position.x, relative_position.y, Color(color, alpha))
			num_pixels_painted += 1
		
	texture = ImageTexture.create_from_image(image)
	return num_pixels_painted
	
func is_out_of_bounds(x: int, y: int, image: Image) -> bool:
	return x < 0 || x >= image.get_width() || y < 0 || y >= image.get_height()
