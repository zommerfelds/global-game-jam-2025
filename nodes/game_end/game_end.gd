extends Control
@onready var score_display_label1 = $ScoreDisplayLabel1
@onready var score_display_label2 = $ScoreDisplayLabel2
@onready var winner_label = $WinnerLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Canvas.texture = Global.canvas_texture
	var formatedScoreP1=Global.score_p1*100
	var formatedScoreP2=Global.score_p2*100
	score_display_label1.text=str("%.1f %%" % formatedScoreP1)
	score_display_label1.set("theme_override_colors/font_color",Color.HOT_PINK)	
	
	$ScoreDisplayLabelSeperator.visible = not Global.coopMode
	if Global.coopMode:
		score_display_label1.position.x = 370
	else:
		score_display_label2.text=str("%.1f %%" % formatedScoreP2)
		score_display_label2.set("theme_override_colors/font_color",Color.BLUE)
	
		if(formatedScoreP1<formatedScoreP2):
			winner_label.modulate=Color.BLUE
			winner_label.text="Blue wins!"
		else:
			winner_label.modulate=Color.HOT_PINK
			winner_label.text="Pink wins!"


# Called every frame. 'delta' is the elapsed time since the previous fram e.
func _process(delta: float) -> void:
	
	if (get_viewport().gui_get_focus_owner() == null
			and (Input.is_action_just_pressed("ui_down")
				or Input.is_action_just_pressed("ui_right")
				or Input.is_action_just_pressed("ui_focus_next"))):
		$RematchButton.grab_focus()
	pass
