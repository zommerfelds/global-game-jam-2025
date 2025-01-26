extends Node2D

var players: Array[PlayerState]

func _ready() -> void:
	for n in get_children():
		if "star_collected" in n:
			n.star_collected.connect(_on_star_collected)
	
	$TileMapLayer.clear()
	for col in range(30):
		for row in range(16):
			#$TileMapLayer.set_cell(Vector2i(9+col, 2+row), 0, Vector2i(0, 10))
			if randi() % 50 == 0:
				var tile = Vector2i(randi() % 8, randi() % 11)
				$TileMapLayer.set_cell(Vector2i(9+col, 2+row), 0, tile)
				$TileMapLayer.set_cell(Vector2i(9+(30-col), 2+row), 0, tile)

func _on_star_collected(player_id: int, is_holy: bool):
	if is_holy:
		players[player_id-1].holy_shots_remaining += 3
	else:
		players[player_id-1].bonus_shots_remaining += 3
