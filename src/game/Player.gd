extends CharacterBody2D


const _SPEED = 200


func _physics_process(delta):
	var x_direction = 0.0
	if Input.is_action_pressed("player_left"):
		x_direction -= 1.0
		
	elif Input.is_action_pressed("player_right"):
		x_direction += 1.0
	
	self.velocity = Vector2(x_direction, 0.0) * self._SPEED
	move_and_slide()
