extends TextureRect


var drag = Vector2.ZERO
var next_match = null


func _ready():
	next_match = $PlayMatch


func _process(delta):
	rect_position = drag


func _input(event):
	if event is InputEventScreenDrag:
		drag.x += event.relative.x
		if drag.x < -3240:
			drag.x = -3240
			
		elif drag.x > 0:
			drag.x = 0
		
		if rect_position.x < -1080:
			next_match.rect_position.x = -rect_position.x
