extends Button


func _pressed():
	GameData.set_random_opponent()
	SceneDirector.change_to("res://src/scenes/game/GameField.tscn")
