extends Node

var splash_image = Image.load_from_file("res://assets/splashes/splash_01_x64.png")
var splash_effect = load("res://nodes/splash_effect.tscn")
var colors = [Color.HOT_PINK, Color.BLUE]
	
func spawn_splashes(amount: int, interval: float = 0.1) -> void:
	var spawned = 0
	var batch_size = 8
	while spawned < amount:
		for i in range(batch_size):
			_spawn_splash_somewhere()
			spawned += 1
		await get_tree().create_timer(interval).timeout

func _spawn_splash_somewhere() -> void:
	var x = randi_range(0, 800)
	var y = randi_range(0, 450)
	
	var color = colors.pick_random()
	var sprite = Sprite2D.new()
	sprite.position = Vector2(x, y)
	sprite.scale = Vector2.ONE * (1 + randf())
	sprite.texture = ImageTexture.create_from_image(splash_image)
	sprite.global_rotation = randf() * 2 * PI
	sprite.modulate = color
	add_child(sprite)
	
	var splash = splash_effect.instantiate()
	splash.color = color
	splash.position = Vector2(x, y);
	add_child(splash)
