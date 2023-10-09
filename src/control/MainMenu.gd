extends CanvasLayer


func _on_FastMatch_pressed():
	GameData._set_random_opponent()
	SceneDirector.change_scene_to_match()


func _on_Championship_pressed():
	SceneDirector.change_scene_to_championship_splash()


func _on_Options_pressed():
	SceneDirector.change_scene_to_options()


func _on_Credits_pressed():
	SceneDirector.change_scene_to_credits()
