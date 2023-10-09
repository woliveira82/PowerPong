extends Node


var _type = null
var _current_round = 0
var _current_phase = null
var match_list = []


func get_type():
	if not _type:
		_type = 'LOCAL'
	return _type


func new_championship():
	var player_position = (randi() % 4) + 1
	for n in range(1, 4):
		var palette_A = _set_random_opponent()
		var palette_B = _set_random_opponent()
		if player_position != n:
			match_list.append($Match.new('Quarter Finals', n, palette_A, palette_B))
		else:
			if randf() > 0.5: 
				match_list.append($Match.new('Quarter Finals', n, GameData.player_name , palette_B, 1))
			else: 
				match_list.append($Match.new('Quarter Finals', n, palette_A, GameData.player_name, 2))


func _set_random_opponent():
	var opponent_list = ["Doe", "Buba", "West", "Brainan"]
	if _type == "NATIONAL":
		opponent_list = ["Buba", "West", "Brainan", "Tight", "Sloth", "Skinny"]
	elif _type == "WORLD":
		opponent_list = ["Tight", "Sloth", "Skinny", "Jack"]
	return  opponent_list[randi() % opponent_list.size()]


func end_match(player_score, opponent_score):
	pass
	SceneDirector.change_scene_to_playoffs()


