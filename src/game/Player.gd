extends CharacterBody2D


const speed = 400


func _physics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("player_left"):
		velocity.x -= 1.0
		
	elif Input.is_action_pressed("player_right"):
		velocity.x += 1.0
	
	set_velocity(velocity * speed)
	move_and_slide()
