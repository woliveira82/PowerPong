extends KinematicBody2D


var _ball = null
var _speed = 500
var _tolerance = 10
var _go_middle = false
# const opponent_list = ["Doe", "Buba", "West", "Brainan", "Tight", "Sloth",
# "skinny", "Jack"]

func _set_opponent(type):
	if not type:
		type = "Doe"
		type = "Brainan"
	
	get_parent().set_opponent_label(type)
	call("_set_" + type)
	

func _ready():
	_ball = get_parent().find_node("Ball")
	_set_opponent(GameData.next_opponent_type)
	_tolerance = [10, 50, 90][randi() % 3]


func _physics_process(delta):
	move_and_slide(Vector2(_get_direction(_go_middle), 0) * _speed)


func _get_direction(_go_middle):
	if _go_middle:
		if _ball.position.y > 960:
			return 1 if position.x < 540 else 0
		
	if abs(_ball.position.x - position.x) > _tolerance:
		return 1 if _ball.position.x > position.x else -1
	
	return 0


func _set_Doe():
	pass


func _set_Buba():
	$Sprite.scale.x = 10
	$CollisionShape2D.shape.set("extents", Vector2(16, 160))


func _set_West():
	_speed = 600


func _set_Brainan():
	_go_middle = true


func _set_Tight():
	_speed = 600
	$Sprite.scale.x = 10
	$CollisionShape2D.shape.set("extents", Vector2(16, 160))


func _set_Sloth():
	_go_middle = true
	$Sprite.scale.x = 10
	$CollisionShape2D.shape.set("extents", Vector2(16, 160))


func _set_Skinny():
	_speed = 600
	_go_middle = true


func _set_Jack():
	_speed = 600
	_go_middle = true
	$Sprite.scale.x = 10
	$CollisionShape2D.shape.set("extents", Vector2(16, 160))
