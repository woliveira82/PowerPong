extends Node

const LOCAL := "LOCAL"
const NATIONAL := "NATIONAL"
const WORLD := "WORLD"

var _type := ""
var _results := {
	"quarter_finals": [],
	"semi_finals": [],
	"final": [],
}

func get_type():
	if not self._type:
		self._type = self.LOCAL
	
	return self.LOCAL


func get_data():
	var data = {"type": self._type}
	data.merge(self._results)
	return data
