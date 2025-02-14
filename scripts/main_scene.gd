extends Node2D

@onready var canvas = $Canvas
@onready var player_1_cannon = $Player1Cannon
@onready var player_2_cannon = $Player2Cannon
@onready var score_p1 = $ScoreBar/Bar/P1Score
@onready var score_p2 = $ScoreBar/Bar/P2Score
@onready var timer_label = $CountDownTimer
@onready var seperator65 = $ScoreBar/Bar/Separator65
@onready var seperator80 = $ScoreBar/Bar/Separator80
@onready var trophy_bronze = $TrophyBronze
@onready var trophy_silver = $TrophySilver
@onready var trophy_gold = $TrophyGold

var bubble_scene = load("res://nodes/bubble.tscn")
var splash_effect = load("res://nodes/splash_effect.tscn")

var player: Array[PlayerState] = [
	PlayerState.new().set_color(Color.HOT_PINK),
	PlayerState.new().set_color(Color.BLUE)
]
var player_id = 1
var current_level: Node2D
var timerStart = false
var defaultTimePerRound = 60 # unit is second
var timeLeft = defaultTimePerRound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.coopMode:
		player[1] = player[0]
		seperator65.visible = true
		seperator80.visible = true
		trophy_bronze.visible = true
		trophy_silver.visible = true
		trophy_gold.visible = true
	else:
		seperator65.visible = false
		seperator80.visible = false
		trophy_bronze.visible = false
		trophy_silver.visible = false
		trophy_gold.visible = false
	var p1_image = Image.create(1, 1, false, Image.FORMAT_RGBA8)
	p1_image.fill(player[0].color)
	var p2_image = Image.create(1, 1, false, Image.FORMAT_RGBA8)
	p2_image.fill(player[1].color)
	score_p1.texture = ImageTexture.create_from_image(p1_image)
	score_p2.texture = ImageTexture.create_from_image(p2_image)
	score_p1.scale.x = 0
	score_p2.scale.x = 0
	player_1_cannon.bubble_fired.connect(_on_bubble_fired)
	player_2_cannon.bubble_fired.connect(_on_bubble_fired)
	$Stand.position.x = get_viewport().size.x / 2
	$Stand.position.y = $Canvas.position.y + $Canvas.area_height / 2 + $Stand.texture.get_size().y/2
	print("Loading " + Global.level_scene)
	current_level = load(Global.level_scene).instantiate()
	current_level.players = player
	timerStart=true
	add_child(current_level)
	$AI.cannon = $Player2Cannon
	
	Global.throphy_collected.connect(_on_thophy_collected)

func _on_bubble_fired(player_id: int, duration: float):
	var is_holy = player[player_id-1].holy_shots_remaining > 0
	player[player_id-1].holy_shots_remaining = max(
		player[player_id-1].holy_shots_remaining - 1, 
		0)
	
	if player[player_id-1].bonus_shots_remaining > 0:
		player[player_id-1].bonus_shots_remaining -= 1
		fire_bubble(player_id, duration, is_holy, 10, 0)
		fire_bubble(player_id, duration, is_holy, 20, 0)
		fire_bubble(player_id, duration, is_holy, 0, 2)
		fire_bubble(player_id, duration, is_holy, -10, 0)
		fire_bubble(player_id, duration, is_holy, -20, 0)
	else:
		fire_bubble(player_id, duration, is_holy)

func fire_bubble(player_id: int, power: float, is_holy: bool = false, delta_angle_deg: float = 0.0, sound: int = 1):
	var bubble = bubble_scene.instantiate()
	var direction
	var color
	if player_id == 1:
		direction = Vector2(1, 0).rotated((player_1_cannon.angle + delta_angle_deg) * PI / 180)
		bubble.position = player_1_cannon.global_position + direction * 50
	else:
		direction = Vector2(-1, 0).rotated(-(player_2_cannon.angle + delta_angle_deg) * PI / 180)
		bubble.position = player_2_cannon.global_position + direction * 50
	bubble.linear_velocity = direction * 500 * (0.7 + power)
	bubble.bubble_burst.connect(_on_bubble_burst)
	bubble.player_id = player_id
	bubble.color = player[player_id-1].color
	bubble.duration = (power ** 0.3) * 0.7
	if randi() % 20 == 0 or Global.cat_mode:
		bubble.cat_mode = true
	bubble.is_holy = is_holy or randi() % 50 == 0
	add_child(bubble)
	if bubble.cat_mode:
		$Meow.pitch_scale = 1 + randf()*0.4 - 0.2
		$Meow.play()
	elif sound == 1:
		$Blub.play()
	elif sound == 2:
		$BigBlub.play()

func _on_bubble_burst(bubble: RigidBody2D):
	$Splat.play()
	var is_holy = bubble.is_holy or (bubble.cat_mode and not Global.cat_mode)
	if is_holy:
		$Hallelujah.play();
	var color = player[bubble.player_id-1].color
	var score = canvas.splash(bubble.position, color, 
								bubble.splash_radius, bubble.is_holy,
								bubble.cat_mode and not Global.cat_mode)
	player[bubble.player_id-1].score += score
		
	var splash = splash_effect.instantiate()
	splash.color = color
	splash.position = bubble.position
	add_child(splash)
	_update_score_labels()

func _update_score_labels():
	var p1_percentage = player[0].score * 1.0 / canvas.area 
	var p2_percentage = player[1].score * 1.0 / canvas.area
	score_p1.scale.x = p1_percentage 
	score_p2.scale.x = 0 if Global.coopMode else p2_percentage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_ai"):
		Global.ai_enabled = not Global.ai_enabled
	if timerStart:
		timeLeft = timeLeft - delta
		timer_label.text = "%.0f" % timeLeft
		if timeLeft < 0 or Input.is_key_pressed(KEY_BACKSPACE): # backspace for debugging
			timerStart = false
			Global.score_p1=player[0].score * 1.0 / canvas.area
			Global.score_p2=player[1].score * 1.0 / canvas.area
			Global.canvas_texture = canvas.texture
			print("Game over! Switching scenes...")
			if Global.coopMode:
				get_tree().change_scene_to_file("res://nodes/game_end/GameEndCoop.tscn")
			else:
				get_tree().change_scene_to_file("res://nodes/game_end/GameEnd.tscn")

func _on_thophy_collected(player_id: int):
	timeLeft = 0
	player[player_id-1].score = canvas.area
