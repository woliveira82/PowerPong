extends CharacterBody2D

const BIGGER_SIZE := Vector2(8.0, 78.0)
const BIGGER_SPRITE_X_SCALE := 2.438
const FASTER_SPEED := 300

var _ball = null
var _speed = 200
var _tolerance = 5
var _go_middle = false

@onready var _sprite := $Sprite2D
@onready var _collision_shape := $CollisionShape2D

func _ready():
	_ball = get_parent().find_child("Ball")
	_set_opponent(GameData.opponent_name)
	_tolerance = [5, 20, 40][randi() % 3]


func _set_opponent(type):
	if not type:
		type = "Doe"
	
	get_parent().set_opponent_label(type)
	call("_set_" + type)
	

func _physics_process(delta):
	self.velocity = Vector2(self._get_direction(), 0.0) * self._speed
	move_and_slide()


func _get_direction():
	if self._go_middle:
		if _ball.position.y > 960:
			return 1 if position.x < 540 else -1
		
	if abs(_ball.position.x - position.x) > _tolerance:
		return 1 if _ball.position.x > position.x else -1
	
	return 0


func _set_Doe():
	pass


func _set_Buba():
	self._sprite.scale.x = BIGGER_SPRITE_X_SCALE
	self._collision_shape.shape.set("size", BIGGER_SIZE)


func _set_West():
	_speed = FASTER_SPEED


func _set_Brainan():
	_go_middle = true


func _set_Tight():
	_speed = FASTER_SPEED
	self._sprite.scale.x = BIGGER_SPRITE_X_SCALE
	self._collision_shape.shape.set("size", BIGGER_SIZE)


func _set_Sloth():
	_go_middle = true
	self._sprite.scale.x = BIGGER_SPRITE_X_SCALE
	self._collision_shape.shape.set("size", BIGGER_SIZE)


func _set_Skinny():
	_speed = FASTER_SPEED
	_go_middle = true


func _set_Jack():
	_speed = FASTER_SPEED
	_go_middle = true
	self._sprite.scale.x = BIGGER_SPRITE_X_SCALE
	self._collision_shape.shape.set("size", BIGGER_SIZE)
