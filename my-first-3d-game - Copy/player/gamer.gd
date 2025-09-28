extends CharacterBody3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



		
func _physics_process(delta):
		const SPEED =5.5
		
		
		var input_direction_2D =Input.get_vector(
			"move_left_4", "move_right_4", "move _forward_4", "move_back_4"
		)
		var input_direction_3D = Vector3(
			input_direction_2D.x, 0.0, input_direction_2D.y
		)
		var direction = transform.basis * input_direction_3D
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		velocity.y -= 20.0 * delta
		
		if Input.is_action_just_pressed("jump_2") and is_on_floor():
			velocity.y = 10.0
		elif Input.is_action_just_released("jump") and velocity.y>0.0:
			velocity.y = 0.0
			
		move_and_slide()
		

		



func _on_exit_zone_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
	
