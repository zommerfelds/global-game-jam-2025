extends Sprite2D

var player_colors = [Color.HOT_PINK, Color.BLUE]
var splash_images = Array()
var area_width: int
var area_height: int
var area: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_width = texture.get_size().x
	area_height = texture.get_size().y
	area = area_width * area_height
	splash_images = [
		Image.load_from_file("res://assets/splashes/splash_01_x64.png"),
		Image.load_from_file("res://assets/splashes/splash_02_x64.png"),
		Image.load_from_file("res://assets/splashes/splash_03_x64.png")
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func splash(position: Vector2, color: Color, radius: float, is_holy: bool, overpaint: bool = false) -> int:
	var paint_position = position - self.position + Vector2(area_width/2, area_height/2)
	return paint_splash(paint_position, color, 2 if is_holy else 1, overpaint)

func paint_splash(position: Vector2, color: Color, scale: float, overpaint: bool = false) -> int:
	var num_pixels_painted = 0
	var splash_image = splash_images[0]
	var splash_width = splash_image.get_width() * scale
	var splash_height = splash_image.get_height() * scale
	var image = texture.get_image()
	var offset = Vector2i(
		- (splash_width / 2),
		- (splash_height / 2))
	var splash_rotation = randf() * PI * 2
	for x in range(splash_width):
		for y in range(splash_height):
			var relative_position = Vector2i(x, y) + Vector2i(position) + offset
			if is_out_of_bounds(relative_position.x, relative_position.y, image):
				continue
			var offset_vector = Vector2(x, y) - splash_image.get_size()*scale/2.0
			var new_source_coords = (offset_vector.rotated(splash_rotation) + splash_image.get_size()*scale/2.0) / scale
			if (is_out_of_bounds(new_source_coords.x, new_source_coords.y, splash_image)):
				continue
			var alpha = splash_image.get_pixel(new_source_coords.x, new_source_coords.y).a
			if (alpha == 0):
				continue
			var color_before = image.get_pixel(relative_position.x, relative_position.y)
			if overpaint or not (isColorSameIgnoringAlpha(color_before, player_colors[0]) or
					isColorSameIgnoringAlpha(color_before, player_colors[1])):
				image.set_pixel(relative_position.x, relative_position.y, Color(color, alpha))
				num_pixels_painted += 1
			elif isColorSameIgnoringAlpha(color_before, color):
				image.set_pixel(relative_position.x, relative_position.y, Color(color, min(1, color_before.a + alpha)))
		
	texture = ImageTexture.create_from_image(image)
	return num_pixels_painted
	
func isColorSameIgnoringAlpha(c1: Color, c2: Color) -> bool:
	return c1.r == c2.r and c1.g == c2.g and c1.b == c2.b
	
func is_out_of_bounds(x: int, y: int, image: Image) -> bool:
	return x < 0 || x >= image.get_width() || y < 0 || y >= image.get_height()
