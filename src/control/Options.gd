extends Panel

@onready var _player_name := $VBox/NameLabel
@onready var _music_on := $VBox/MusicCheck
@onready var _sound_on := $VBox/SoundCheck


func _on_Save_pressed():
	# GameData.save_options(_player_name.text, _music_on.pressed, _sound_on.pressed)
	SceneDirector.change_scene_to_menu()
	

func _on_Cancel_pressed():
	SceneDirector.change_scene_to_menu()
