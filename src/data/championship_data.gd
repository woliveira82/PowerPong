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

#{
#	"player_1": "nome",
#	"results_1": [0,0,0],
#	"player_2": "nome 2",
#	"results_2": [0, 0, 0],
#}


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


func _start_new_championship(type):
	self._type = type
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


func _create_brackets(players: Array):
	var final_match := Match.new(STAGE.FINAL, null, 0)
	self._matches.append(final_match)
	
	var semi_1 := Match.new(STAGE.SEMI, final_match, 1)
	var semi_2 := Match.new(STAGE.SEMI, final_match, 2)
	self._matches.append_array([semi_1, semi_2])
	
	var quarter_1 := Match.new(STAGE.QUARTERS, semi_1, 1)
	quarter_1.set_players(players[0], players[1])
	var quarter_2 := Match.new(STAGE.QUARTERS, semi_1, 2)
	quarter_2.set_players(players[2], players[3])
	var quarter_3 := Match.new(STAGE.QUARTERS, semi_2, 1)
	quarter_3.set_players(players[4], players[5])
	var quarter_4 := Match.new(STAGE.QUARTERS, semi_2, 2)
	quarter_4.set_players(players[6], players[7])
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
	
	func set_players(player1: String, player2: String):
		self._player1 = player1
		self._player2 = player2
	
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
