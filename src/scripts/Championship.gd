extends Node


var _type = null
var _current_round = 0
var _current_phase = null
var _player_position = 0
var quarter_finals = []
var semi_finals = []
var final_match = null


class Match:
	pass


func get_type():
	if not _type:
		_type = 'LOCAL'
	
	return _type


func new_championship():

		
	for n in range(1, 4):
		var m = Match.new()
		quarter_finals.append(m)


func set_random_opponent():
	var opponent_list = ["Doe", "Buba", "West", "Brainan"]
	if _type == "NATIONAL":
		opponent_list = ["Buba", "West", "Brainan", "Tight", "Sloth", "Skinny"]
	
	elif _type == "WORLD":
		opponent_list = ["Tight", "Sloth", "Skinny", "Jack"]
	
	return  opponent_list[randi() % opponent_list.size()]


func set_next_match():
	pass


func end_match(player_score, opponent_score):
	pass
	SceneDirector.change_to("res://src/scenes/control/Playoffs.tscn")


