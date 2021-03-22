extends Node

var player_score = 0
var opponent_score = 0


func _ready():
	$MatchTimer.start()
	$MatchTimer.paused = true
	_count_and_play()


func set_opponent_label(opponent_name):
	$Interface/OpponentName.text = opponent_name


func _count_and_play():
	$Ball.stop()
	$Interface/BallLabel.visible = true
	$BallTimer.start()


func _process(delta):
	$Interface/TimerLabel.text = str(int($MatchTimer.time_left) + 1)
	$Interface/BallLabel.text = str(int($BallTimer.time_left) + 1)


func _on_PlayerGoal_body_entered(body):
	_score_from_player(false)
	_count_and_play()


func _on_OpponentGoal_body_entered(body):
	_score_from_player(true)
	_count_and_play()


func _score_from_player(confirm: bool):
	$MatchTimer.paused = true
	if confirm:
		player_score += 1
		$Interface/PlayerScore.text = str(player_score)
	
	else:
		opponent_score += 1
		$Interface/OpponentScore.text = str(opponent_score)


func _on_BallTimer_timeout():
	$Interface/BallLabel.visible = false
	$MatchTimer.paused = false
	$Ball.start()


func _on_MatchTimer_timeout():
	$Ball.stop()
	var final_result = "DRAW"
	if player_score > opponent_score:
		final_result = "YOU\nWIN"
		
	elif player_score < opponent_score:
		final_result = "YOU\nLOSE"
	
	$Interface/Result.text = final_result
	$Interface/ResultPanel.visible = true
	$Interface/AnimationPlayer.play("end_game")


func end_game():
	GameData.end_game(player_score, opponent_score)
