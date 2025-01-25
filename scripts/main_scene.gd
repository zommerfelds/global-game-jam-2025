extends Node2D

@onready var canvas = $Canvas
@onready var player_1_cannon = $Player1Cannon
@onready var player_2_cannon = $Player2Cannon


var bubble_scene = load("res://nodes/bubble.tscn")

const player_colors = [Color.HOT_PINK, Color.BLUE]

var player_id = 1
var player_1_score = 0
var player_2_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_1_cannon.bubble_fired.connect(_on_bubble_fired)
	player_2_cannon.bubble_fired.connect(_on_bubble_fired)
	player_1_cannon.position.x = 10 + 50
	player_1_cannon.position.y = get_viewport().size.y - 10 - 50
	player_2_cannon.position.x = get_viewport().size.x - 10 - 50
	player_2_cannon.position.y = get_viewport().size.y - 10 - 50
	player_1_cannon.scale *= 100.0/332
	player_2_cannon.scale *= 100.0/332

func _on_bubble_fired(player_id):
	var bubble = bubble_scene.instantiate()
	var direction
	var color
	if player_id == 1:
		direction = Vector2(1, 0).rotated(player_1_cannon.angle * PI / 180)
		bubble.position = player_1_cannon.global_position + direction * 50
		color = player_colors[0]
	else:
		direction = Vector2(-1, 0).rotated(-player_2_cannon.angle * PI / 180)
		bubble.position = player_2_cannon.global_position + direction * 50
		color = player_colors[1]
	bubble.velocity = direction * 300 # Adjust speed as needed
	bubble.bubble_burst.connect(_on_bubble_burst)
	bubble.color = color
	add_child(bubble)

func _on_bubble_burst(position: Vector2, color: Color, radius: float = 50):
	$Splat.play()
	canvas.splash(position, color, radius)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
