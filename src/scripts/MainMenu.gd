extends CanvasLayer


func _on_FastMatch_pressed():
	GameData._set_random_opponent()
	SceneDirector.change_to("res://src/scenes/game/GameField.tscn")


func _on_Championship_pressed():
	# SceneDirector.change_to("res://src/scenes/control/ChampionshipSplash.tscn")
	pass


func _on_Options_pressed():
	SceneDirector.change_to("res://src/scenes/control/Options.tscn")


func _on_Credits_pressed():
	SceneDirector.change_to("res://src/scenes/control/Credits.tscn")
