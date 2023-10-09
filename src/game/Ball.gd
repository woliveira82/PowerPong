extends CharacterBody2D


const MAX_SPEED := 700
const INITIAL_POSITION := Vector2(135.0, 240.0)
const INITIAL_SPEED := 200
var speed := 0


func _process(delta):
	var collision = move_and_collide(self.velocity * self.speed * delta)
	if collision:
		if collision.get_collider() is Wall:
			self.velocity = self.velocity.bounce(collision.get_normal())

		else:
			var pallete_x = collision.get_collider().position.x
			var new_x = (self.position.x - pallete_x) / 64
			var new_y = sqrt(1 - pow(new_x, 2))
			if velocity.y > 0:
				new_y = -new_y
				
			velocity = Vector2(new_x, new_y)
			speed += 50 if speed < MAX_SPEED else 0


func stop():
	self.speed = 0
	self.position = INITIAL_POSITION


func start():
	var new_y = randf_range(0.4, 0.8)
	var new_x = sqrt(1 - pow(new_y, 2))
	new_x = new_x * [1, -1][randi() % 2]
	new_y = new_y * [1, -1][randi() % 2]
	self.speed = INITIAL_SPEED
	velocity = Vector2(new_x, new_y)
