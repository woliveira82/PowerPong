extends CanvasLayer

var current_cup = null
var data = null


func _ready():
	current_cup = GameData.get_championship()
	data = $Data
	_set_playoff_cup(current_cup.get_type())
	_set_labels()


func _set_playoff_cup(cup_type):
	if cup_type == "NATIONAL":
		data.get_node("RegionalCup").visible = false
		data.get_node("NationalCup").visible = true
		data.get_node("WorldCup").visible = false
	elif cup_type == "WORLD":
		data.get_node("RegionalCup").visible = false
		data.get_node("NationalCup").visible = false
		data.get_node("WorldCup").visible = true


func _set_labels():
	for m in current_cup.match_list:
		if m:
			var order = m.final_order
			var fase = 'Q'
			if m.final_level == 'Semi Finals':
				fase = 'S'
			elif m.final_level == 'Final Match':
				fase = 'F'
			
			var label_name = 'Player%s%d' % [fase, order * 2]
			data.get_node(label_name).text = m.palette_1_name
			for i in m.palette_1_score:
				var score_name = "Score%s%dM%d" % [fase, order * 2, i]
				data.get_node(score_name).text = str(i)
				
			label_name = 'Player%s%d' % [fase, (order * 2) + 1]
			data.get_node(label_name).text = m.palette_1_name
			for i in m.palette_1_score:
				var score_name = "Score%s%dM%d" % [fase, (order * 2) + 1, i]
				data.get_node(score_name).text = str(i)
