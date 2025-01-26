extends Control
@onready var score_display_label1 = $ScoreDisplayLabel1
@onready var stars_label = $StarsLabel
@onready var hint_label = $HintLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Canvas.texture = Global.canvas_texture
	var formatedScoreP1=Global.score_p1*100
	score_display_label1.text=str("%.1f %%" % formatedScoreP1)
	score_display_label1.set("theme_override_colors/font_color",Color.HOT_PINK)	
	
	score_display_label1.position.x = 370
	stars_label.modulate=Color.HOT_PINK
	
	if(Global.score_p1<0.5):
		stars_label.text="Nice try."
		hint_label.text = "Try to cover 50 % of the canvas to get a star."
	elif(Global.score_p1<0.6):
		stars_label.text="1 Star!"
		hint_label.text = "Try to get 60 % for 2 stars."
	elif(Global.score_p1<0.7):
		stars_label.text="2 Stars!"
		hint_label.text = "Try to get 70 % for all 3 stars."
	else:
		stars_label.text="3 Stars!"
		hint_label.text = "You are an amazing team!"

# Called every frame. 'delta' is the elapsed time since the previous fram e.
func _process(delta: float) -> void:
	
	if (get_viewport().gui_get_focus_owner() == null
			and (Input.is_action_just_pressed("ui_down")
				or Input.is_action_just_pressed("ui_right")
				or Input.is_action_just_pressed("ui_focus_next"))):
		$RematchButton.grab_focus()
	pass
