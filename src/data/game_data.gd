extends Node

var _player_name = "PLAYER"
var _music_on = true
var _effects_on = true
var _option_file_path = "res://assets/options.json"


func _ready():
	randomize()
	self._load_options()


func get_player_name():
	return self._player_name


func get_music_on():
	return self._music_on


func get_effects_on():
	return self._effects_on


func _load_options():
	var file = FileAccess.open(self._option_file_path, FileAccess.READ)
	var test_json_conv = JSON.new()
	test_json_conv.parse(file.get_as_text())
	var options = test_json_conv.get_data()
	file.close()
	self._player_name = options['player_name']
	self._music_on = options['music_on']
	self._effects_on = options['effects_on']


func save_options(player_name: String, music_on: bool, effects_on: bool):
	self._player_name = player_name if player_name.length() > 0 else "PLAYER"
	self._music_on = music_on
	self._effects_on = effects_on
	self._store_options()


func _store_options():
	var options = {
		'player_name': self._player_name,
		'music_on': self._music_on,
		'effects_on': self._effects_on,
	}
	var file = FileAccess.open(self._option_file_path, FileAccess.WRITE)
	file.store_line(JSON.new().stringify(options))
	file.close()
