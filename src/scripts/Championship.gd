extends Node


var _type = null
var _current_round = 0
var _player_position = 0

var final_match = null


func _ready():
	final_match = $FinalMatch

func get_type():
	if not _type:
		_type = "REGIONAL"
	
	if _current_round == 0:
		_new_championship()
		_current_round = 1
	
	return _type


func _new_championship():
	for p in [1, 2, 3, 4, 5, 6, 7, 8]:
		set_player("Quarter", p, set_random_opponent())

	_player_position = (randi() % 8) +1
	set_player("Quarter", _player_position, set_random_opponent(), true)
	
	

func set_random_opponent():
	var opponent_list = ["Doe", "Buba", "West", "Brainan"]
	if _type == "NATIONAL":
		opponent_list = ["Doe", "Buba", "West", "Brainan", "Tight", "Sloth", "Skinny", "Jack"]
	
	elif _type == "WORLD":
		opponent_list = ["Tight", "Sloth", "Skinny", "Jack"]
	
	return  opponent_list[randi() % opponent_list.size()]
	

func end_match():
	pass


func get_player(phase, order):
	return final_match.get_player(phase, order)


func set_player(phase, order, value, player=false):
	return final_match.set_player(phase, order, value, player)


func get_result(phase, order, match_order):
	return final_match.get_result(phase, order, match_order)


func set_result(phase, order, match_order, value):
	return final_match.set_result(phase, order, match_order)
