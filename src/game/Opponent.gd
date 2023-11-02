extends CharacterBody2D
class_name Opponent

enum { FASTER, BIGGER, TATICAL }
static var type := {
	"DOE": [],
	"BUBA": [BIGGER],
	"WEST": [FASTER],
	"BRAINAN": [TATICAL],
	"TIGHT": [BIGGER, FASTER],
	"SLOTH": [BIGGER, TATICAL],
	"SKINNY": [FASTER, TATICAL],
	"JACK": [FASTER, BIGGER, TATICAL]
}

const MIDDLE_FIELD := Vector2(135.0, 240.0)

const BIGGER_SIZE := Vector2(8.0, 78.0)
const BIGGER_SPRITE_X_SCALE := 2.438
const FASTER_SPEED := 225

var ball: Node2D
var _speed := 180
var _tolerance := 5
var _go_middle := false
var current_type: String

@onready var _sprite := $Sprite2D
@onready var _collision_shape := $CollisionShape2D


func set_opponent(new_type: String):
	current_type = new_type
	var status = Opponent.type[new_type]
	if FASTER in status:
		self._speed = FASTER_SPEED
	
	if BIGGER in status:
		self._sprite.scale.x = BIGGER_SPRITE_X_SCALE
		self._collision_shape.shape.set("size", BIGGER_SIZE)
	
	if TATICAL in status:
		self._go_middle = true
	
	self._tolerance = randi_range(5, 15)


func _physics_process(_delta):
	self.velocity = Vector2(self._get_direction(), 0.0) * self._speed
	move_and_slide()


func _get_direction():
	if self._go_middle and ball.position.y > MIDDLE_FIELD.y:
		if abs(self.position.x - MIDDLE_FIELD.x) < self._tolerance:
			return 0
		
		return 1 if position.x < MIDDLE_FIELD.x else -1
		
	if abs(ball.position.x - position.x) > self._tolerance:
		return 1 if ball.position.x > position.x else -1
	
	return 0
