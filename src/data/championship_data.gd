extends Node

enum STAGE {FINAL, SEMI, QUARTERS}
var _STAGE_MAP := {
	1: [STAGE.QUARTERS, 0],
	2: [STAGE.QUARTERS, 1],
	3: [STAGE.QUARTERS, 2],
	4: [STAGE.SEMI, 0],
	5: [STAGE.SEMI, 1],
	6: [STAGE.SEMI, 2],
	7: [STAGE.FINAL, 0],
	8: [STAGE.FINAL, 1],
	9: [STAGE.FINAL, 2]
}
const LOCAL := "LOCAL"
const NATIONAL := "NATIONAL"
const WORLD := "WORLD"

var _active_stage := 0
var _type := ""
var _matches : Array[Match] = []


func _ready():
	Signals.championship_match_ended.connect(_on_championship_match_ended)


func get_type():
	if not self._type:
		self._start_new_championship(self.LOCAL)
	
	return self.LOCAL


func get_data():
	var matches = []
	for item in self._matches:
		matches.append(item.dict())
		
	return {
		"type": self._type,
		"matches": matches,
	}


func get_next_opponent():
	var opponent_name := ""
	for m in self._matches:
		opponent_name = m.get_opponent_active_player()
		if opponent_name != "":
			return opponent_name
	
	return "JACK"


func _start_new_championship(type):
	self._type = type
	self._active_stage = 1
	var championship_players := ["PLAYER"]
	_add_opponents(championship_players)
	_create_brackets(championship_players)


func _add_opponents(players: Array):
	var opponents_list = _get_opponents_list()
	for _i in range(7):
		players.append(opponents_list.pick_random())
	
	players.shuffle()


func _get_opponents_list():
	var opponents = Opponent.type.duplicate(true)
	var opponent_list = opponents.keys()
	
	if self._type == ChampionshipData.LOCAL:
		opponent_list.filter(func(key): return opponents[key].size() < 2)
	
	elif self._type == ChampionshipData.NATIONAL:
		opponent_list.filter(func(key): return opponents[key].size() < 3)
	
	else:
		opponent_list.filter(func(key): return opponents[key].size() > 0)
	
	return opponent_list


func _parse_name(player_name: String):
	if player_name != "PLAYER":
		return [player_name, false]
	
	return [GameData.get_player_name(), true]


func _create_brackets(players: Array):
	var final_match := Match.new(STAGE.FINAL, null, 0)
	self._matches.append(final_match)
	
	var semi_1 := Match.new(STAGE.SEMI, final_match, 1)
	var semi_2 := Match.new(STAGE.SEMI, final_match, 2)
	self._matches.append_array([semi_1, semi_2])
	
	var name_parsed
	var quarter_1 := Match.new(STAGE.QUARTERS, semi_1, 1)
	name_parsed = self._parse_name(players[0])
	quarter_1.set_player1(name_parsed[0], name_parsed[1])
	name_parsed = self._parse_name(players[1])
	quarter_1.set_player2(name_parsed[0], name_parsed[1])
	
	var quarter_2 := Match.new(STAGE.QUARTERS, semi_1, 2)
	name_parsed = self._parse_name(players[2])
	quarter_2.set_player1(name_parsed[0], name_parsed[1])
	name_parsed = self._parse_name(players[3])
	quarter_2.set_player2(name_parsed[0], name_parsed[1])
	
	var quarter_3 := Match.new(STAGE.QUARTERS, semi_2, 1)
	name_parsed = self._parse_name(players[4])
	quarter_3.set_player1(name_parsed[0], name_parsed[1])
	name_parsed = self._parse_name(players[5])
	quarter_3.set_player2(name_parsed[0], name_parsed[1])
	
	var quarter_4 := Match.new(STAGE.QUARTERS, semi_2, 2)
	name_parsed = self._parse_name(players[6])
	quarter_4.set_player1(name_parsed[0], name_parsed[1])
	name_parsed = self._parse_name(players[7])
	quarter_4.set_player2(name_parsed[0], name_parsed[1])
	
	self._matches.append_array([quarter_1, quarter_2, quarter_3, quarter_4])


func _on_championship_match_ended(player_score, opponent_score):
	# TEST
	player_score = 1
	var parse_stage = _STAGE_MAP[self._active_stage]
	var stage = parse_stage[0]
	var match_round = parse_stage[1]
	for m in self._matches:
		if not m.is_stage(stage) or m.ended():
			continue
		
		if m.get_human_player() == 0:
			m.random_result(match_round)
		
		else:
			if m.get_human_player() == 1:
				m.set_player1_score(match_round, player_score)
				m.set_player2_score(match_round, opponent_score)
				
			else:
				m.set_player2_score(match_round, player_score)
				m.set_player1_score(match_round, opponent_score)
		
		if match_round >= 1:
			m.proccess_victory()
			
	self._active_stage += 1


class Match:
	var _player1: String = "-"
	var _player1_score := ["-", "-", "-"]
	var _player2: String = "-"
	var _player2_score := ["-", "-", "-"]
	
	var _stage : STAGE
	var _ended : bool = false
	var _human_player : int = 0
	
	var _next_match : Match
	var _next_position: int
	
	func _init(stage: STAGE, next_match: Match, next_position: int):
		self._stage = stage
		self._next_match = next_match
		self._next_position = next_position
	
	func ended():
		return self._ended
	
	func set_player1(new_name: String, human: bool):
		self._player1 = new_name
		if human:
			self._human_player = 1
	
	func get_player1() -> String:
		return self._player1
	
	func set_player2(new_name: String, human: bool):
		self._player2 = new_name
		if human:
			self._human_player = 2
	
	func get_player2() -> String:
		return self._player2
	
	func set_player1_score(index: int, value: int):
		self._player1_score[index] = str(value)
	
	func set_player2_score(index: int, value: int):
		self._player2_score[index] = str(value)
	
	func is_stage(stage: STAGE):
		return self._stage == stage
	
	func get_opponent_active_player() -> String:
		var opponent_name = ""
		if self._human_player != 0 and not self._ended:
			if self._human_player == 1:
				opponent_name = self._player2
			else:
				opponent_name = self._player1
		
		return opponent_name
	
	func get_human_player():
		return self._human_player
	
	func _get_winner():
		var p1_victories := 0
		var p2_victories := 0
		var total_rounds := 0
		for match_round in range(3):
			if self._player1_score[match_round] == "-":
				continue
			
			if int(self._player1_score[match_round]) > int(self._player2_score[match_round]):
				p1_victories += 1
			elif int(self._player1_score[match_round]) < int(self._player2_score[match_round]):
				p2_victories += 1
			
			total_rounds += 1
		
		if p1_victories == 2:
			return 1
		
		if p2_victories == 2:
			return 2
		
		if total_rounds == 3:
			if p2_victories > p1_victories:
				return 2
			
			return 1
		
		return 0
	
	func proccess_victory():
		var winner = self._get_winner()
		if winner == 0:
			return
		
		self._ended = true
		var winner_name = self._player1 if winner == 1 else self._player2
		if self._next_position == 1:
			self._next_match.set_player1(winner_name, self._human_player == 1)
		else:
			self._next_match.set_player2(winner_name, self._human_player == 2)
	
	func random_result(match_round: int):
		self._player1_score[match_round] = str(Opponent.type[self._player1].size() + randi() % 5)
		self._player2_score[match_round] = str(Opponent.type[self._player2].size() + randi() % 5)
	
	func dict():
		return {
			player1 = self._player1,
			player1_score = self._player1_score,
			player2 = self._player2, 
			player2_score = self._player2_score, 
			stage = self._stage, 
			ended = self._ended, 
			human_player = self._human_player, 
			next_match = self._next_match, 
			next_position = self._next_position, 
		}
