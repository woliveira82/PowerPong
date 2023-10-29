extends Node

var _opponent_type := ""
var _championship_match := false


func _ready():
	Signals.match_ended.connect(_on_match_ended)


func set_championship_opponent(opponent: String):
	self._championship_match = true
	self._opponent_type = opponent


func get_opponent():
	if not _opponent_type:
		var types : Array = Opponent.type.keys()
		return types.pick_random()
	
	return self._opponent_type


func _on_match_ended(player_score, opponent_score):
	self._opponent_type = ""
	if self._championship_match:
		Signals.championship_match_ended.emit(player_score, opponent_score)
		SceneDirector.change_scene_to_playoffs()
