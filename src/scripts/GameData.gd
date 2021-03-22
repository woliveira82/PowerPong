extends Node


var next_opponent_type = null

var player_name = "Player"
var music_on = true
var effects_on = true


func _ready():
	randomize()


func end_game(player_score, opponent_score):
	SceneDirector.change_to("res://src/scenes/control/MainMenu.tscn")
	


func set_random_opponent():
	var opponent_list = ["Doe", "Buba", "West", "Brainan", "Tight", "Sloth", "Skinny", "Jack"]
	next_opponent_type = opponent_list[randi() % 8]


func save_options(pn, mo, eo):
	player_name = pn
	music_on = mo
	effects_on = eo
	# Save



