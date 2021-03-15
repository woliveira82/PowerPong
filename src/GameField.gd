extends Node

var player_score = 0
var enemy_score = 0


func _on_PlayerGoal_body_entered(body):
	$Ball.stop()
	_score_from_player(false)
	$Ball.reset()


func _on_EnemyGoal_body_entered(body):
	$Ball.stop()
	_score_from_player(true)
	$Ball.reset()


func _score_from_player(confirm: bool):
	if confirm:
		player_score += 1
		$Interface/PlayerScore.text = str(player_score)
	
	else:
		enemy_score += 1
		$Interface/EnemyScore.text = str(enemy_score)
