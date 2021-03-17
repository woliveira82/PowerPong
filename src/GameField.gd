extends Node

var player_score = 0
var enemy_score = 0


func _ready():
	_count_and_play()
	$MatchTimer.start()


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


func _on_EnemyGoal_body_entered(body):
	_score_from_player(true)
	_count_and_play()


func _score_from_player(confirm: bool):
	if confirm:
		player_score += 1
		$Interface/PlayerScore.text = str(player_score)
	
	else:
		enemy_score += 1
		$Interface/EnemyScore.text = str(enemy_score)


func _on_BallTimer_timeout():
	$Interface/BallLabel.visible = false
	$Ball.start()
