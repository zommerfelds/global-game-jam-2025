extends Node2D

var players: Array[PlayerState]

func _ready() -> void:
	$Star.star_collected.connect(_on_star_collected)

func _on_star_collected(player_id: int):
	players[player_id-1].bonus_shots_remaining += 3

func _process(delta: float) -> void:
	pass
