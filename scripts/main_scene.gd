extends Node2D

@onready var canvas = $Canvas
@onready var player_1_cannon = $Player1Cannon
@onready var player_2_cannon = $Player2Cannon
var bubble_scene = load("res://nodes/bubble.tscn")

var player_id = 1
var player_1_score = 0
var player_2_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_1_cannon.bubble_fired.connect(_on_bubble_fired)
	player_2_cannon.bubble_fired.connect(_on_bubble_fired)

func _on_bubble_fired(player_id):
	var bubble = bubble_scene.instantiate()
	var direction
	if player_id == 1:
		direction = Vector2(1, 0).rotated(player_1_cannon.angle * PI / 180)
		bubble.position = player_1_cannon.global_position + direction * 50
	else:
		direction = Vector2(-1, 0).rotated(-player_2_cannon.angle * PI / 180)
		bubble.position = player_2_cannon.global_position + direction * 50
	bubble.velocity = direction * 300 # Adjust speed as needed
	bubble.bubble_burst.connect(_on_bubble_burst)
	add_child(bubble)

func _on_bubble_burst():
	$Splat.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
