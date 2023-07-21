extends Node


var final_level
var final_order

var player_is_palette = 0

var palette_1_name = ''
var palette_1_score = [null, null, null]
var palette_2_name = ''
var palette_2_score = [null, null, null]


func _init(level,order,palette_A,palette_B,player_palette=0):
	final_level = level
	final_order = order
	palette_1_name = palette_A
	palette_2_name = palette_B
	player_is_palette = player_palette
	if final_level == 'Final Match':
		palette_1_score = [null, null, null, null, null]
		palette_2_score = [null, null, null, null, null]

