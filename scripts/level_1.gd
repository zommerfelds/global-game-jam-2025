extends Node2D


func _ready() -> void:
	$Star.star_collected.connect(_on_star_collected)

func _on_star_collected(player_id: int):
	print(player_id)

func _process(delta: float) -> void:
	pass
