extends ColorRect

@onready var _match_container := $MatchContainer
@onready var _play_container := $PlayContainer
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


func _show_play_container():
	self._match_container.hide()
	self._play_container.show()


func _show_match_container():
	self._play_container.hide()
	self._match_container.show()


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and self._player != 0:
			self._show_play_container()


func _on_cancel_button_pressed():
	self._show_match_container()


func _on_play_button_pressed():
	SceneDirector.change_scene_to_match()
