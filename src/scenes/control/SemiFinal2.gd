extends Node


var _competitor_1 = ""
var _competitor_2 = ""
var _c1_player = false
var _c2_player = false
var final_winner = null
var match_result = []
const _match = {"result": [null, null], "winner": 0}

var quarter_final_1 = null
var quarter_final_2 = null


func _ready():
	quarter_final_1 = $QuarterFinal1
	quarter_final_2 = $QuarterFinal2
	
	
func run_match():
	_check_winner()
	if not final_winner:
		if _c1_player:
			GameData.next_opponent_type = _competitor_2
			SceneDirector.change_to("res://src/scenes/game/GameField.tscn")

		elif _c2_player:
			GameData.next_opponent_type = _competitor_1
			SceneDirector.change_to("res://src/scenes/game/GameField.tscn")

		else:
			var m = len(match_result)
			match_result[m] = _match
			match_result[m]["result"][0] = randi() % 10
			match_result[m]["result"][1] = randi() % 10
			_check_match_winner(m)


func _check_match_winner(m):
	var c1 = match_result[m]["result"][0]
	var c2 = match_result[m]["result"][1]
	if c1 > c2:
		match_result[m]["winner"] = 1
	
	elif c2 > c1:
		match_result[m]["winner"] = 2

	_check_winner()


func _check_winner():
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
	
	else:
		final_winner = _competitor_1


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
				_c1_player = true

		else:
			_competitor_2 = value
			if player:
				_c2_player = true

	if order < 3:
		quarter_final_1.set_player(phase, order, value, player)
	
	else:
		order -=2
		quarter_final_2.set_player(phase, order, value, player)


func get_result(phase, order, match_order):
	if phase == "Semi":
		if len(match_result) >= match_order:
			return match_result[match_order]["result"][order -1]
			
		else:
			return null

	if order < 3:
		return quarter_final_1.get_result(phase, order, match_order)
	
	else:
		order -=2
		return quarter_final_2.get_result(phase, order, match_order)
