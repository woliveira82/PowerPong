extends ColorRect

@onready var _player1_name := $MatchContainer/PlayerContainer1/PlayerName
@onready var _p1_score1 := $MatchContainer/PlayerContainer1/Score1
@onready var _p1_score2 := $MatchContainer/PlayerContainer1/Score2
@onready var _p1_score3 := $MatchContainer/PlayerContainer1/Score3
@onready var _player2_name := $MatchContainer/PlayerContainer2/PlayerName
@onready var _p2_score1 := $MatchContainer/PlayerContainer2/Score1
@onready var _p2_score2 := $MatchContainer/PlayerContainer2/Score2
@onready var _p2_score3 := $MatchContainer/PlayerContainer2/Score3

var _player := 0


func set_match(data: Dictionary):
	self._player1_name.text = data.player1
	self._p1_score1.text = str(data.player1_score[0])
	self._p1_score2.text = str(data.player1_score[1])
	self._p1_score3.text = str(data.player1_score[2])
	self._player2_name.text = data.player2
	self._p2_score1.text = str(data.player2_score[0])
	self._p2_score2.text = str(data.player2_score[1])
	self._p2_score3.text = str(data.player2_score[2])
	if data.human_player >= 0:
		self._player = data.human_player
