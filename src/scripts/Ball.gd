extends CharacterBody2D


const MAX_SPEED = 1500
var speed = 0


func _process(delta):
	var collision_info = move_and_collide(velocity * speed * delta)
	if collision_info:
		if collision_info.collider.name == "Wall":
			velocity = velocity.bounce(collision_info.normal)
			
		else:
			var pallete_x = collision_info.collider.position.x
			var new_x = (position.x - pallete_x) / 150
			var new_y = sqrt(1 - pow(new_x, 2))
			if velocity.y > 0:
				new_y = -new_y
				
			velocity = Vector2(new_x, new_y)
			speed += 100 if speed < MAX_SPEED else 0


func stop():
	speed = 0
	position = Vector2(540, 960)


func start():
	var new_y = randf_range(0.4, 0.8)
	var new_x = sqrt(1 - pow(new_y, 2))
	new_x = new_x * [1, -1][randi() % 2]
	new_y = new_y * [1, -1][randi() % 2]
	speed = 500
	velocity = Vector2(new_x, new_y)
