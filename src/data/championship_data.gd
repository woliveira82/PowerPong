extends Node

const LOCAL := "LOCAL"
const NATIONAL := "NATIONAL"
const WORLD := "WORLD"

var _type := ""
var _quarter_finals := []
var _semi_finals := []
var _final_match := {}


func get_type():
	if not self._type:
		self._start_new_championship(self.LOCAL)
	
	return self.LOCAL


func get_data():
	return {
		"type": self._type,
		"quarter_finals": self._quarter_finals,
		"semi_finals": self._semi_finals,
		"final": self._final_match,
	}


func _start_new_championship(type):
	self._type = type
	var opponents_list = self._get_opponents_list()
	var championship_players = ["PLAYER"]
	for index in range(7):
		championship_players.append(opponents_list.pick_random())
	
	championship_players.shuffle()
	for index in range(4):
		self._quarter_finals.append({
			"player_1": championship_players.pop_front(),
			"results_1": [null, null, null],
			"player_2": championship_players.pop_front(),
			"results_2": [null, null, null],
		})


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
