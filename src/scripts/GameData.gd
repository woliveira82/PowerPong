extends Node

var player_name = "Player"
var opponent_name = "Doe"
var music_on = true
var effects_on = true
var _championship = null
var _option_file_path = "res://assets/options.json"


func _ready():
	randomize()
	_load_options()


func save_options(pn, mo, eo):
	player_name = pn if len(pn) > 0 else "Player"
	music_on = mo
	effects_on = eo
	_store_options(player_name, music_on, effects_on)


func _store_options(player_name, music_on, effects_on):
	var options = {
		'player_name': player_name,
		'music_on': music_on,
		'effects_on': effects_on,
	}
	var file = File.new()
	file.open(_option_file_path, File.WRITE)
	file.store_line(to_json(options))
	file.close()


func _load_options():
	var file = File.new()
	if not file.file_exists(_option_file_path):
		return
	
	file.open(_option_file_path, file.READ)
	var options = parse_json(file.get_as_text())
	file.close()
	player_name = options['player_name']
	music_on = options['music_on']
	effects_on = options['effects_on']


func end_match(player_score, opponent_score):
	if not _championship:
		SceneDirector.change_to("res://src/scenes/control/MainMenu.tscn")
	else:
		_championship.end_match(player_score, opponent_score)


func get_championship():
	_championship = $Championship
	return _championship


func _set_random_opponent():
	opponent_name = $Championship._set_random_opponent()
