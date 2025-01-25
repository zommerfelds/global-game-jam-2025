extends Node

var color: Color = Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# TODO fix that it does not override the color globally on the material...
	$GPUParticles2D.process_material.color = color
	$GPUParticles2D.restart()
