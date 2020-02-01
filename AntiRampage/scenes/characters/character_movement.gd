extends KinematicBody

var speed = Vector3()
var gravity = -9.81
var move_spd = 30
var rotation_spd = 5
var is_grabbing = false
var is_moveable = true

func _ready():
	pass 
	
func _physics_process(delta):
	speed.y += gravity * delta
	input_processing(delta)
	move_and_slide(speed, Vector3(0,1,0))
	
	
func input_processing(delta):
	if (is_moveable):
		if (Input.is_action_pressed("tecla_a")):
			rotation_degrees.y += rotation_spd
			
		if (Input.is_action_pressed("tecla_w")):
			speed += (move_spd*delta) * global_transform.basis.z.normalized()
			
		if (Input.is_action_pressed("tecla_s")):
			speed += (-move_spd*delta) * global_transform.basis.z.normalized()
	
		if (Input.is_action_pressed("tecla_d")):
			rotation_degrees.y -= rotation_spd
		
	if (Input.is_action_just_released("tecla_a") || Input.is_action_just_released("tecla_d")):
		speed = Vector3(0,0,0)
		
	if (Input.is_action_just_released("tecla_w") || Input.is_action_just_released("tecla_s")):
		speed = Vector3(0,0,0)
	
	if (Input.is_action_just_pressed("tecla_x")):
		if (!is_grabbing):
			grab_object()
		else:
			release_object()
		
	if (Input.is_action_just_released("tecla_x")):
		pass
		


func grab_object():
	while (rotation_degrees.x < 20):
		rotation_degrees.x += 1
	is_grabbing = true
	is_moveable = false


func release_object():
	while (rotation_degrees.x > 0):
		rotation_degrees.x -= 1
	is_grabbing = false
	is_moveable = true
