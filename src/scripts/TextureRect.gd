extends TextureRect


var drag = Vector2.ZERO
const min_x = -3240
const max_x = 0


func _process(delta):
	rect_position = drag


func _input(event):
	if event is InputEventScreenDrag:
		drag.x += event.relative.x
		if drag.x < min_x:
			drag.x = min_x
			
		elif drag.x > max_x:
			drag.x = max_x
