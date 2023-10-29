extends Node

var player_score := 0
var opponent_score := 0

@onready var _match_timer := $MatchTimer
@onready var _timer_label := $Interface/TimerLabel
@onready var _ball_timer := $BallTimer
@onready var _restart_label := $Interface/RestartLabel

@onready var _opponent_name := $Interface/OpponentName
@onready var _opponent_score := $Interface/OpponentScore
@onready var _player := $Interface/AnimationPlayer
@onready var _player_name := $Interface/PlayerName
@onready var _player_score := $Interface/PlayerScore

@onready var _ball := $Ball
@onready var _opponent := $Opponent

@onready var _result_panel := $Interface/ResultPanel
@onready var _result_label := $Interface/ResultPanel/Result


func _ready():
	self._set_opponent(MatchData.get_opponent())
	self._player_name.text = GameData.get_player_name()
	self._match_timer.start()
	self._match_timer.paused = true
	self._result_panel.visible = false
	self._count_and_play()


func _count_and_play():
	_ball.stop()
	_restart_label.visible = true
	_ball_timer.start()


func _process(_delta):
	_timer_label.text = str(int(_match_timer.time_left))
	_restart_label.text = str(int(_ball_timer.time_left) + 1)


func _on_PlayerGoal_body_entered(_body):
	_score_from_player(false)
	_count_and_play()


func _on_OpponentGoal_body_entered(_body):
	_score_from_player(true)
	_count_and_play()


func _score_from_player(confirm: bool):
	_match_timer.paused = true
	if confirm:
		player_score += 1
		_player_score.text = str(player_score)
	
	else:
		opponent_score += 1
		_opponent_score.text = str(opponent_score)


func _on_restart_label_timeout():
	_restart_label.visible = false
	_match_timer.paused = false
	_ball.start()


func _on_BallTimer_timeout():
	_restart_label.visible = false
	_match_timer.paused = false
	_ball.start()


func _on_MatchTimer_timeout():
	self._ball.stop()
	var final_result = "DRAW"
	if player_score > opponent_score:
		final_result = "YOU\nWON"
		
	elif player_score < opponent_score:
		final_result = "YOU\nLOSED"
	
	_result_label.text = final_result
	_result_panel.visible = true
	_player.play("end_game")


func end_game():
	Signals.match_ended.emit(player_score, opponent_score)


func _set_opponent(opponent_name):
	_opponent.set("ball", _ball)
	_opponent.set_opponent(opponent_name)
	_opponent_name.text = opponent_name
