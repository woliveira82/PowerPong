extends Button


func _pressed():
	GameData.get_championship().set_next_match()
	if GameData.next_opponent_type:
		print("Game field")
		print(GameData.next_opponent_type)
		SceneDirector.change_to("res://src/scenes/game/GameField.tscn")
	
	else: 
		print("Sem oponente")
		print(GameData.next_opponent_type)
		SceneDirector.change_to("res://src/scenes/control/Playoffs.tscn")
