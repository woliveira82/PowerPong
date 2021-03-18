extends KinematicBody2D


var ball = null
var speed = 500
var tolerance = 10
var name = "Opponent"
# const opponent_list = ["Doe", "Buba", "West", "Brainan", "Tight", "Sloth",
# "skinny", "Jack"]

func _set_opponent(type):
	call("_set_" + type)
	

func _ready():
	ball = get_parent().find_node("Ball")
	_set_opponent($GameData.next_opponent_type)


func _physics_process(delta):
	move_and_slide(Vector2(_get_direction(), 0) * speed)


func _get_direction():
	if abs(ball.position.x - position.x) > tolerance:
		return 1 if ball.position.x > position.x else -1
	
	return 0


func _set_Doe():
	name = "Doe"
	tolerance = [10, 50, 90][randi()]


func _set_Buba():
	name = "Buba"


func _set_West():
	name = "West"
	
	
func _set_Brainan():
	name = "Brainan"
	
	
func _set_Tight():
	name = "Tight"


func _set_Sloth():
	name = "Sloth"


func _set_Skinny():
	name = "Skinny"


func _set_Jack():
	name = "Jack"
