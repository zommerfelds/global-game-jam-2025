extends Control
@onready var score_display_label = $ScoreDisplayLabel
@onready var winner_label = $WinnerLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var formatedScoreP1=Global.score_p1*100
	var formatedScoreP2=Global.score_p2*100
	score_display_label.text=str("%.2f" % formatedScoreP1, "% : ", "%.2f" % formatedScoreP2, "%")
	if(formatedScoreP1<formatedScoreP2):
		winner_label.modulate=Color.BLUE
		winner_label.text="Player 2 wins!"
	else:
		winner_label.modulate=Color.HOT_PINK
		winner_label.text="Player 1 wins"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous fram e.
func _process(delta: float) -> void:
	pass
