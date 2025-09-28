extends CharacterBody3D
class_name Player

@export var speed := 5.0
@export var jump_force := 6.0
@export var gravity := 9.8
@onready var gun_sound: AudioStreamPlayer3D = $"gun sound"

var is_dead := false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.7
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.5
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -60.0, 30.0
		)
	
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
func _physics_process(delta):
		const SPEED =5.5
		
		
		var input_direction_2D =Input.get_vector(
			"move_left", "move_right", "move_forward", "move_back"
		)
		var input_direction_3D = Vector3(
			input_direction_2D.x, 0.0, input_direction_2D.y
		)
		var direction = transform.basis * input_direction_3D
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		velocity.y -= 20.0 * delta
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = 10.0
		elif Input.is_action_just_released("jump") and velocity.y>0.0:
			velocity.y = 0.0
			
		move_and_slide()
		
		if Input.is_action_pressed("shoot") and %Timer.is_stopped():
			shoot_bullet()
		
func shoot_bullet():
	const BULLET_3D = preload("res://player/bullet_3d.tscn")
	var new_bullet = BULLET_3D.instantiate()
	%Marker3D.add_child(new_bullet)
	
	new_bullet.global_transform = %Marker3D.global_transform
	gun_sound.play()
	%Timer.start()


func _on_exit_zone_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
	
