extends Object
class_name PlayerState

var score: int = 0
var color: Color
var bonus_shots_remaining: int = 0
var holy_shots_remaining: int = 0

func set_color(color: Color) -> PlayerState:
	self.color = color
	return self
