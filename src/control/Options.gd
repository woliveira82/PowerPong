extends ColorRect

@onready var _player_name := $VBox/NameEdit
@onready var _music_check := $VBox/MusicCheck
@onready var _effects_check := $VBox/EffectsCheck


func _ready():
	self._player_name.text = GameData.get_player_name()
	self._music_check.button_pressed = GameData.get_music_on()
	self._effects_check.button_pressed = GameData.get_effects_on()


func _on_Save_pressed():
	GameData.save_options(
		self._player_name.text,
		self._music_check.button_pressed,
		self._effects_check.button_pressed,
	)
	SceneDirector.change_scene_to_menu()
	

func _on_Cancel_pressed():
	SceneDirector.change_scene_to_menu()
