extends KinematicBody2D


var ball = null
var speed = 500
var tolerance = 10


func _set_opponent(type):
	pass
	

func _ready():
	ball = get_parent().find_node("Ball")


func _physics_process(delta):
	move_and_slide(Vector2(_get_direction(), 0) * speed)


func _get_direction():
	if abs(ball.position.x - position.x) > tolerance:
		return 1 if ball.position.x > position.x else -1
	
	return 0
