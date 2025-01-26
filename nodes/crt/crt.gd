extends Node2D

var is_visible: bool:
	set(value):
		$CanvasLayer.visible = value
	get(): return $CanvasLayer.visible
