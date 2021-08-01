extends Node


var next_opponent_type = null
var next_opponent_order = null
var next_match_order = null
var player_name = "Player"
var music_on = true
var effects_on = true
var _championship = null


func _ready():
	randomize()


func save_options(pn, mo, eo):
	player_name = pn if len(pn) > 0 else 'Player'
	music_on = mo
	effects_on = eo
	# Save


func end_match(player_score, opponent_score):
	if not _championship:
		SceneDirector.change_to("res://src/scenes/control/MainMenu.tscn")
	
	else:
		_championship.end_match(player_score, opponent_score)


func get_championship():
	_championship = $Championship
	return _championship
