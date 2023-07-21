extends CharacterBody2D


var _ball = null
var _speed = 500
var _tolerance = 10
var _go_middle = false


func _ready():
	_ball = get_parent().find_child("Ball")
	_set_opponent(GameData.opponent_name)
	_tolerance = [10, 50, 90][randi() % 3]


func _set_opponent(type):
	if not type:
		type = "Doe"
	
	get_parent().set_opponent_label(type)
	call("_set_" + type)
	

func _physics_process(delta):
	set_velocity(Vector2(_get_direction(_go_middle), 0) * _speed)
	move_and_slide()


func _get_direction(_go_middle):
	if _go_middle:
		if _ball.position.y > 960:
			return 1 if position.x < 540 else -1
		
	if abs(_ball.position.x - position.x) > _tolerance:
		return 1 if _ball.position.x > position.x else -1
	
	return 0


func _set_Doe():
	pass


func _set_Buba():
	$Sprite2D.scale.x = 10
	$CollisionShape2D.shape.set("size", Vector2(16, 160))


func _set_West():
	_speed = 600


func _set_Brainan():
	_go_middle = true


func _set_Tight():
	_speed = 600
	$Sprite2D.scale.x = 10
	$CollisionShape2D.shape.set("size", Vector2(16, 160))


func _set_Sloth():
	_go_middle = true
	$Sprite2D.scale.x = 10
	$CollisionShape2D.shape.set("size", Vector2(16, 160))


func _set_Skinny():
	_speed = 600
	_go_middle = true


func _set_Jack():
	_speed = 600
	_go_middle = true
	$Sprite2D.scale.x = 10
	$CollisionShape2D.shape.set("size", Vector2(16, 160))
