extends CanvasLayer

var current_cup = null
var data = null


func _ready():
	current_cup = GameData.get_championship()
	data = $Data
	_set_playoff_cup(current_cup.get_type())
	_set_player_names()
	_set_player_scores()


func _set_playoff_cup(cup_type):
	if cup_type == "NATIONAL":
		data.get_node("RegionalCup").visible = false
		data.get_node("NationalCup").visible = true
		data.get_node("WorldCup").visible = false
	
	elif cup_type == "WORLD":
		data.get_node("RegionalCup").visible = false
		data.get_node("NationalCup").visible = false
		data.get_node("WorldCup").visible = true


func _set_player_names():
	for q in [1, 2, 3, 4, 5, 6, 7, 8]:
		var label_name = "PlayerQ%d" % q
		print(current_cup.get_player("Quarter", q))
		data.get_node(label_name).text = current_cup.get_player("Quarter", q)
	
	for q in [1, 2, 3, 4]:
		var label_name = "PlayerS%d" % q
		data.get_node(label_name).text = current_cup.get_player("Semi", q)
		
	data.get_node("PlayerF1").text = current_cup.get_player("Final", 1)
	data.get_node("PlayerF2").text = current_cup.get_player("Final", 2)


func _set_player_scores():
	for q in [1, 2, 3, 4, 5, 6, 7, 8]:
		for m in [1, 2, 3]:
			var label_name = "ScoreQ%dM%d" % [q, m]
			var attribute_name = "quarter_score_%d" % q
			var result = current_cup.get_result("Quarter", q, m)
			if not result:
				result = "-"
			data.get_node(label_name).text = str(result)
	
	for q in [1, 2, 3, 4]:
		for m in [1, 2, 3]:
			var label_name = "ScoreS%dM%d" % [q, m]
			var attribute_name = "semi_score_%d" % q
			var result = current_cup.get_result("Semi", q, m)
			if not result:
				result = "-"
				
			data.get_node(label_name).text = str(result)
	
	for q in [1, 2]:
		for m in [1, 2, 3, 4, 5]:
			var label_name = "ScoreF%dM%d" % [q, m]
			var attribute_name = "final_score_%d" % q
			var result = current_cup.get_result("Final", q, m)
			if not result:
				result = "-"
				
			data.get_node(label_name).text = str(result)
