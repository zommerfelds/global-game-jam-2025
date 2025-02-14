extends Node

# save some variables that needs to be shared between scenes
var score_p1 = 0
var score_p2 = 0
var canvas_texture: Texture2D
var level_scene = "res://nodes/levels/level_1.tscn"
var coopMode = false
var cat_mode = false
var soundtrack: AudioStreamPlayer
var ai_enabled: bool = false

signal throphy_collected(player_id: int)

var soundtrack_id = 0
const SOUNDTRACKS = [
	preload("res://assets/soundtrack_2.mp3"),
	preload("res://assets/soundtrack_0.mp3"),
	preload("res://assets/soundtrack_1.mp3"),
]

func _ready() -> void:
	print("Welcome to a bubble game!")
	soundtrack = AudioStreamPlayer.new()
	soundtrack.stream = SOUNDTRACKS[soundtrack_id]
	# Is that the right way to auto-loop?
	soundtrack.finished.connect(loop_soundtrack)
	add_child(soundtrack)
	soundtrack.play()

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
	if Input.is_action_just_pressed("toggle_background_music"):
		soundtrack.playing = not soundtrack.playing
	if Input.is_action_just_pressed("next_background_music"):
		next_soundtrack()
		soundtrack.play()
	if Input.is_action_just_pressed("toggle_cats"):
		cat_mode = not cat_mode

func next_soundtrack():
	soundtrack_id = (soundtrack_id + 1) % len(SOUNDTRACKS)
	soundtrack.stream = SOUNDTRACKS[soundtrack_id]
	
func loop_soundtrack():
	next_soundtrack()
	soundtrack.play()

const LEVELS = {
	"Level1": "res://nodes/levels/level_1.tscn",
	"Level2": "res://nodes/levels/level_2.tscn",
	"Level3": "res://nodes/levels/level_3.tscn",
	"Level4": "res://nodes/levels/level_4.tscn",
	"Level5": "res://nodes/levels/level_5.tscn",
	"LevelRandom": "res://nodes/levels/level_random.tscn"
}

func start_level(level_code: String):
	Global.level_scene = LEVELS[level_code]
	get_tree().change_scene_to_file("res://nodes/main_scene.tscn")
