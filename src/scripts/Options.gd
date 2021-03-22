extends CanvasLayer

var _player_name = null
var _music_on = null
var _sound_on = null


func _ready():
	_player_name = $Panel/VBox/VBoxPlayerName/LineEdit
	_music_on = $Panel/VBox/VBoxAudio/MusicCheck
	_sound_on = $Panel/VBox/VBoxAudio/SoundCheck


func _on_Save_pressed():
	GameData.save_options(_player_name.text, _music_on.pressed, _sound_on.pressed)
	SceneDirector.change_to("res://src/scenes/control/MainMenu.tscn")
	

func _on_Cancel_pressed():
	SceneDirector.change_to("res://src/scenes/control/MainMenu.tscn")
