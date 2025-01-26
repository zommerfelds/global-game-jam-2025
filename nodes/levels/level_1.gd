extends Node2D

var players: Array[PlayerState]

func _ready() -> void:
	$Star.star_collected.connect(_on_star_collected)
	$Star2.star_collected.connect(_on_star_collected)
	$Star3.star_collected.connect(_on_star_collected)

func _on_star_collected(player_id: int, is_holy: bool):
	if is_holy:
		players[player_id-1].holy_shots_remaining += 3
	else:
		players[player_id-1].bonus_shots_remaining += 3

func _process(delta: float) -> void:
	pass
