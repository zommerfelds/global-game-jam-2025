extends Object
class_name PlayerState

var score: int = 0
var color: Color

func set_color(color: Color) -> PlayerState:
	self.color = color
	return self
