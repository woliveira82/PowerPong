extends KinematicBody2D


var speed = 500
var velocity = Vector2(0.8, 1)


func _process(delta):
	var collision_info = move_and_collide(velocity * speed * delta)
	if collision_info:
		if collision_info.collider.name == "Wall":
			velocity = velocity.bounce(collision_info.normal)
			
		else:
			var pallete_x = collision_info.collider.position.x
			var diff_x = position.x - pallete_x
			print("Diferenca", diff_x)
			#print("Ball", position.x)
			velocity = velocity.bounce(collision_info.normal)
			
		speed += 100 if speed < 1500 else 0


func stop():
	speed = 0


func reset():
	position = Vector2(540, 960)
	speed = 500
	velocity = Vector2(0.8, 1)
