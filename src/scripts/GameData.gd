extends Node


var next_opponent_type = null

func set_random_opponent():
	var opponent_list = ["Doe", "Buba", "West", "Brainan", "Tight", "Sloth", "skinny", "Jack"]
	next_opponent_type = opponent_list[randi() % 8]

