extends Control
@onready var score_display_label1 = $ScoreDisplayLabel1
@onready var stars_label = $StarsLabel
@onready var hint_label = $HintLabel
@onready var trophy_bronze = $TrophyBronze
@onready var trophy_silver = $TrophySilver
@onready var trophy_gold = $TrophyGold

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Canvas.texture = Global.canvas_texture
	var formatedScoreP1=Global.score_p1*100
	score_display_label1.text=str("%.1f %%" % formatedScoreP1)
	score_display_label1.set("theme_override_colors/font_color",Color.HOT_PINK)	
	
	stars_label.modulate=Color.HOT_PINK
	trophy_bronze.visible = false
	trophy_silver.visible = false
	trophy_gold.visible = false
	
	if(Global.score_p1<0.1):
		stars_label.text="Nice try."
		hint_label.text = "Try to cover 50 % of the canvas to get a trophy."
	elif(Global.score_p1<0.6):
		trophy_bronze.visible = true
		stars_label.modulate=Color.DARK_ORANGE
		stars_label.text="Bronze!"
		hint_label.text = "Try to get 60 % for silver."
	elif(Global.score_p1<0.7):
		trophy_silver.visible = true
		stars_label.modulate=Color.SILVER
		stars_label.text="Silver!"
		hint_label.text = "Try to get 70 % for gold."
	else:
		trophy_gold.visible = true
		stars_label.modulate=Color.GOLDENROD
		stars_label.text="Gold!"
		hint_label.text = "You are an amazing team!"

# Called every frame. 'delta' is the elapsed time since the previous fram e.
func _process(delta: float) -> void:
	
	if (get_viewport().gui_get_focus_owner() == null
			and (Input.is_action_just_pressed("ui_down")
				or Input.is_action_just_pressed("ui_right")
				or Input.is_action_just_pressed("ui_focus_next"))):
		$RematchButton.grab_focus()
	pass
