extends Node


var final_level
var final_order

var palette_1_player = false
var palette_2_player = false

var palette_1_name = ''
var palette_1_score = [null, null, null]
var palette_2_name = ''
var palette_2_score = [null, null, null]


func _ready():
	if final_level == 'Final Match':
		palette_1_score = [5]
		palette_2_score = [5]
		


