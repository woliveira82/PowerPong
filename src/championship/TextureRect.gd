extends TextureRect


var drag = Vector2.ZERO
var next_match = null


func _ready():
	next_match = $PlayMatch


func _process(delta):
	position = drag


func _input(event):
	if event is InputEventScreenDrag:
		drag.x += event.relative.x
		if drag.x < -3240:
			drag.x = -3240
			
		elif drag.x > 0:
			drag.x = 0
		
		if position.x < -1080:
			next_match.position.x = -position.x
