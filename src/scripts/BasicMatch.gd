extends Node


var _competitor_1 = ""
var _competitor_2 = ""
var _c1_player = false
var _c2_player = false
var final_winner = null
var match_result = []


func set_next_match(current_round, order):
	_check_winner()
	if not final_winner:
		if _c1_player:
			GameData.next_match_order = len(match_result)
			GameData.next_opponent_order = order + 2
			GameData.next_opponent_type = _competitor_2

		elif _c2_player:
			GameData.next_match_order = len(match_result)
			GameData.next_opponent_order = order + 1
			GameData.next_opponent_type = _competitor_1

		else:
			var m = len(match_result)
			match_result.append({"result": [null, null], "winner": 0})
			match_result[m]["result"][0] = randi() % 10
			match_result[m]["result"][1] = randi() % 10
			_check_match_winner(m)


func check_results():
	var winner_1 = semi_final_1.get_winner()
	var winner_2 = semi_final_2.get_winner()
	if not winner_1:
		semi_final_1.check_results()
	
	else:
		_competitor_1 = winner_1
	
	if not winner_2:
		semi_final_2.check_results()
	
	else:
		_competitor_2 = winner_2


func _check_match_winner(m):
	var c1 = match_result[m]["result"][0]
	var c2 = match_result[m]["result"][1]
	if not c1 or not c2:
		return
		
	if c1 > c2:
		match_result[m]["winner"] = 1
	
	elif c2 > c1:
		match_result[m]["winner"] = 2

	_check_winner()


func _check_winner():
	final_winner = null
	var winner_1 = 0
	var winner_2 = 0
	for m in match_result:
		if m["winner"] == 1:
			winner_1 += 1
		
		elif m["winner"] == 2:
			winner_2 += 1
	
	if winner_1 >= 2:
		final_winner = _competitor_1
	
	elif winner_2 >= 2:
		final_winner = _competitor_2
	
	elif len(match_result) >= 3:
		final_winner = _competitor_1


func get_winner():
	if not final_winner:
		return null
	
	var competitor = "_competitor_%d" % final_winner
	return get(competitor)


func get_player(phase, order):
	return _competitor_1 if order == 1 else _competitor_2


func set_player(phase, order, value, player):
	if order == 1:
		_competitor_1 = value
		if player:
			_c1_player = true
				
	else:
		_competitor_2 = value
		if player:
			_c2_player = true


func get_result(phase, order, match_order):
	if len(match_result) >= match_order:
		return match_result[match_order -1]["result"][order -1]
		
	else:
		return null


func set_result(phase, order, match_order, value):
	while len(match_result) <= match_order:
		match_result.append({"result": [null, null], "winner": 0})
	
	match_result[match_order]["result"][order -1] = value
	_check_match_winner(match_order)
