extends ColorRect

@onready var _player1_name := $MatchContainer/PlayerContainer1/PlayerName
@onready var _p1_score1 := $MatchContainer/PlayerContainer1/Score1
@onready var _p1_score2 := $MatchContainer/PlayerContainer1/Score2
@onready var _p1_score3 := $MatchContainer/PlayerContainer1/Score3
@onready var _player2_name := $MatchContainer/PlayerContainer2/PlayerName
@onready var _p2_score1 := $MatchContainer/PlayerContainer2/Score1
@onready var _p2_score2 := $MatchContainer/PlayerContainer2/Score2
@onready var _p2_score3 := $MatchContainer/PlayerContainer2/Score3


func set_match(data):
	self._player1_name.text = data["player_1"]
	self._p1_score1.text = data["results_1"][0] if data["results_1"][0] else "-"
	self._p1_score2.text = data["results_1"][1] if data["results_1"][1] else "-"
	self._p1_score3.text = data["results_1"][2] if data["results_1"][2] else "-"
	self._player2_name.text = data["player_2"]
	self._p2_score1.text = data["results_2"][0] if data["results_2"][0] else "-"
	self._p2_score2.text = data["results_2"][1] if data["results_2"][1] else "-"
	self._p2_score3.text = data["results_2"][2] if data["results_2"][2] else "-"
