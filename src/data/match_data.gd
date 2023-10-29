extends Node

var _opponent_type := ""


func _ready():
	Signals.match_ended.connect(_on_match_ended)


func set_opponent(opponent: String):
	self._opponent_type = opponent


func get_opponent():
	if not _opponent_type:
		var types : Array = Opponent.type.keys()
		return types.pick_random()
	
	return self._opponent_type



func _on_match_ended(_player_score, _opponent_score):
	self._opponent_type = ""
