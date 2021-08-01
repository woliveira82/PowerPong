extends Node


var _competitor_1 = ""
var _competitor_2 = ""
var c1_player = false
var c2_player = false
var final_winner = null
var final_winner_player = false
var match_result = []

var quarter_final_1 = null
var quarter_final_2 = null


func _ready():
	quarter_final_1 = $QuarterFinal1
	quarter_final_2 = $QuarterFinal2
	
	
func set_next_match(current_phase, current_round, order):
	if current_phase != "Semi":
		quarter_final_1.set_next_match(current_round, order)
		quarter_final_2.set_next_match(current_round, order + 2)
	
	else:
		_check_winner()
		if not final_winner:
			if c1_player:
				GameData.next_match_order = len(match_result)
				GameData.next_opponent_order = order + 2
				GameData.next_opponent_type = _competitor_2
			
			elif c2_player:
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
	var winner_1 = quarter_final_1.get_winner()
	var winner_2 = quarter_final_2.get_winner()
	if not winner_1:
		quarter_final_1.check_results()
	
	else:
		_competitor_1 = winner_1
		if quarter_final_1.final_winner_player:
			c1_player = true
	
	if not winner_2:
		quarter_final_2.check_results()
	
	else:
		_competitor_2 = winner_2
		if quarter_final_2.final_winner_player:
			c2_player = true


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
		if c1_player:
			final_winner_player = true
	
	elif winner_2 >= 2:
		final_winner = _competitor_2
		if c2_player:
			final_winner_player = true
	
	elif len(match_result) >= 3:
		if winner_1 > winner_2:
			final_winner = _competitor_1
			if c1_player:
				final_winner_player = true
	
		elif winner_2 > winner_1:
			final_winner = _competitor_2
			if c2_player:
				final_winner_player = true
		
		else:
			final_winner = _competitor_1
			if c1_player:
				final_winner_player = true


func get_winner():
	return final_winner


func get_player(phase, order):
	if phase == "Semi":
		return _competitor_1 if order == 1 else _competitor_2

	if order < 3:
		return quarter_final_1.get_player(phase, order)
	
	else:
		order -=2
		return quarter_final_2.get_player(phase, order)


func set_player(phase, order, value, player):
	if phase == "Semi":
		if order ==1:
			_competitor_1 = value
			if player:
				c1_player = true

		else:
			_competitor_2 = value
			if player:
				c2_player = true

	if order < 3:
		quarter_final_1.set_player(phase, order, value, player)
	
	else:
		order -=2
		quarter_final_2.set_player(phase, order, value, player)


func get_result(phase, order, match_order):
	if phase == "Semi":
		if len(match_result) >= match_order:
			return match_result[match_order -1]["result"][order -1]
			
		else:
			return null

	if order < 3:
		return quarter_final_1.get_result(phase, order, match_order)
	
	else:
		order -=2
		return quarter_final_2.get_result(phase, order, match_order)


func set_result(phase, order, match_order, value):
	if phase == "Semi":
		while len(match_result) <= match_order:
			match_result.append({"result": [null, null], "winner": 0})
			
		match_result[match_order][order -1] = value
		_check_match_winner(match_order)

	if order < 3:
		quarter_final_1.set_result(phase, order, match_order, value)
	
	else:
		order -=2
		quarter_final_2.set_result(phase, order, match_order, value)
