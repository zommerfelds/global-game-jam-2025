extends Node2D

@onready var canvas = $Canvas
@onready var player_1_cannon = $Player1Cannon
@onready var player_2_cannon = $Player2Cannon
@onready var score_p1 = $ScoreBar/P1Score
@onready var score_p2 = $ScoreBar/P2Score

var bubble_scene = load("res://nodes/bubble.tscn")

const player_colors = [Color.HOT_PINK, Color.BLUE]

var player_id = 1
var player_1_score = 0
var player_2_score = 0
var soundtrack_id = 0
const SOUNDTRACKS = [preload("res://assets/soundtrack_0.mp3"), preload("res://assets/soundtrack_1.mp3")]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p1_image = Image.create(1, 1, false, Image.FORMAT_RGBA8)
	p1_image.fill(player_colors[0])
	var p2_image = Image.create(1, 1, false, Image.FORMAT_RGBA8)
	p2_image.fill(player_colors[1])
	score_p1.texture = ImageTexture.create_from_image(p1_image)
	score_p2.texture = ImageTexture.create_from_image(p2_image)
	score_p1.scale.x = 0
	score_p2.scale.x = 0
	player_1_cannon.bubble_fired.connect(_on_bubble_fired)
	player_2_cannon.bubble_fired.connect(_on_bubble_fired)
	$Soundtrack.play()
	$Stand.position.x = get_viewport().size.x / 2
	$Stand.position.y = $Canvas.position.y + $Canvas.area_height / 2 + $Stand.texture.get_size().y/2

func _on_bubble_fired(player_id: int, duration: float):
	var bubble = bubble_scene.instantiate()
	var direction
	var color
	if player_id == 1:
		direction = Vector2(1, 0).rotated(player_1_cannon.angle * PI / 180)
		bubble.position = player_1_cannon.global_position + direction * 50
	else:
		direction = Vector2(-1, 0).rotated(-player_2_cannon.angle * PI / 180)
		bubble.position = player_2_cannon.global_position + direction * 50
	bubble.linear_velocity = direction * 500 * (0.7 + duration)
	bubble.bubble_burst.connect(_on_bubble_burst)
	bubble.player_id = player_id
	bubble.color = player_colors[player_id-1]
	bubble.duration = (duration ** 0.3) * 0.7
	add_child(bubble)
	$Blub.play()

func _on_bubble_burst(position: Vector2, player_id: int, radius: float):
	$Splat.play()
	if randi() % 100 == 0:
		$Hallelujah.play();
	var score = canvas.splash(position, player_colors[player_id-1], radius)
	if player_id == 1:
		player_1_score += score
	else:
		player_2_score += score
	_update_score_labels()

func _update_score_labels():
	var p1_percentage = player_1_score * 1.0 / canvas.area
	var p2_percentage = player_2_score * 1.0 / canvas.area
	score_p1.scale.x = p1_percentage
	score_p2.scale.x = p2_percentage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_background_music"):
		$Soundtrack.playing = not $Soundtrack.playing
	if Input.is_action_just_pressed("next_background_music"):
		soundtrack_id = (soundtrack_id + 1) % len(SOUNDTRACKS)
		$Soundtrack.stream = SOUNDTRACKS[soundtrack_id]
		$Soundtrack.play()
