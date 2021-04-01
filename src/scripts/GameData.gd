extends Node


var next_opponent_type = null
var last_opponent_result = null
var last_player_result = null

var player_name = "Player"
var music_on = true
var effects_on = true
var _championship = null


func _ready():
	randomize()


func end_match(player_score, opponent_score):
	last_opponent_result = opponent_score
	last_player_result = player_score
	if not _championship:
		SceneDirector.change_to("res://src/scenes/control/MainMenu.tscn")
	
	else:
		_championship.end_match()


func set_random_opponent():
	var opponent_list = ["Doe", "Buba", "West", "Brainan", "Tight", "Sloth", "Skinny", "Jack"]
	next_opponent_type = opponent_list[randi() % 8]


func save_options(pn, mo, eo):
	player_name = pn
	music_on = mo
	effects_on = eo
	# Save


func get_championship():
	_championship = $Championship
	return _championship

