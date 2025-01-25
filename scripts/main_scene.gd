extends Node2D

@onready var canvas = $Canvas
@onready var player_1_cannon = $Player1Cannon
@onready var player_2_cannon = $Player2Cannon
@onready var player_1_score_label = $Player1Score
@onready var player_2_score_label = $Player2Score

var bubble_scene = load("res://nodes/bubble.tscn")

const player_colors = [Color.HOT_PINK, Color.BLUE]

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
	var color
	if player_id == 1:
		direction = Vector2(1, 0).rotated(player_1_cannon.angle * PI / 180)
		bubble.position = player_1_cannon.global_position + direction * 50
	else:
		direction = Vector2(-1, 0).rotated(-player_2_cannon.angle * PI / 180)
		bubble.position = player_2_cannon.global_position + direction * 50
	bubble.velocity = direction * 300 # Adjust speed as needed
	bubble.bubble_burst.connect(_on_bubble_burst)
	bubble.player_id = player_id
	add_child(bubble)

func _on_bubble_burst(position: Vector2, player_id: int, radius: float = 50):
	$Splat.play()
	var score = canvas.splash(position, player_colors[player_id-1], radius)
	if player_id == 1:
		player_1_score += score
	else:
		player_2_score += score
	_update_score_labels()

func _update_score_labels():
	player_1_score_label.text = "Player 1\n" + str(player_1_score)
	player_2_score_label.text = "Player 2\n" + str(player_2_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
