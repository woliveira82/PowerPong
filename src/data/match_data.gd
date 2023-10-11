extends Node

var _opponent_type := ""


func _ready():
	Signals.match_ended.connect(_on_match_ended)
	Signals.field_loaded.connect(_on_field_loaded)


func get_opponent():
	if not _opponent_type:
		var types : Array = Opponent.type.keys()
		return types.pick_random()
	
	return self._opponent_type


func _on_field_loaded():
	Signals.match_data_setted.emit(self.get_opponent())


func _on_match_ended(_player_score, _opponent_score):
	self._opponent_type = ""
