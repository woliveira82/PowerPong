extends Node

enum STAGE {FINAL, SEMI, QUARTERS}
var _STAGE_MAP := {
	1: [STAGE.QUARTERS, 1],
	2: [STAGE.QUARTERS, 2],
	3: [STAGE.QUARTERS, 3],
	4: [STAGE.SEMI, 1],
	5: [STAGE.SEMI, 2],
	6: [STAGE.SEMI, 3],
	7: [STAGE.FINAL, 1],
	8: [STAGE.FINAL, 2],
	9: [STAGE.FINAL, 3]
}
const LOCAL := "LOCAL"
const NATIONAL := "NATIONAL"
const WORLD := "WORLD"

var _active_stage := 0

var _type := ""
var _quarter_finals := []
var _semi_finals := []
var _final_match := {}

var _matches := []


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

func _parse_name(name: String):
	if name != "PLAYER":
		return [name, false]
	
	return ["PLAYER", true]
	
	
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
	
	func _init(stage: STAGE, next_match: Match, next_position: bool):
		self._stage = stage
		self._next_match = next_match
		self._next_position = next_position
	
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
	
	func get_opponent_active_player() -> String:
		var opponent_name = ""
		if self._human_player != 0 and not self._ended:
			if self._human_player == 1:
				opponent_name = self._player2
			else:
				opponent_name = self._player1
		
		return opponent_name
	
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
