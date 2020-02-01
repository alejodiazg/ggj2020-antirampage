extends KinematicBody

var speed = Vector3()
var gravity = -9.81
var move_spd = 30
var rotation_spd = 1
var is_grabbing = false
var is_moveable = true
var character
var camera

const SPEED = 6
const ACCELERATION = 3
const DE_ACCELERATION = 5

func _ready():
	character = get_node(".")	
	pass 
		
func _physics_process(delta):
	input_processing(delta)
	#move_and_slide(speed, Vector3(0,1,0))
	
	
func input_processing(delta):
	camera = get_node("target/Camera").get_global_transform()
	var dir = Vector3()
	var is_moving = false
	
	if (is_moveable):
		if(Input.is_action_pressed("tecla_w")):
			dir += -camera.basis[2]
			is_moving = true
		if(Input.is_action_pressed("tecla_s")):
			dir += camera.basis[2]
			is_moving = true
		if(Input.is_action_pressed("tecla_a")):
			dir += -camera.basis[0]
			is_moving = true
		if(Input.is_action_pressed("tecla_d")):
			dir += camera.basis[0]
			is_moving = true
		
		dir.y = 0
		dir = dir.normalized()
		
			
		speed.y += delta * gravity
		
		var hv = speed
		hv.y = 0
		
		var new_pos = dir * move_spd
		var accel = 1
		
		if (dir.dot(hv) > 0):
			accel = 1
			
		hv = hv.linear_interpolate(new_pos, accel * delta)
		
		speed.x = hv.x
		speed.z = hv.z
				
		speed = move_and_slide(speed, Vector3(0,1,0))	
		
		if is_moving:
			
			# Rotate the player to direction
			var angle = atan2(hv.x, hv.z)
			
			var char_rot = character.get_rotation()
			
			char_rot.y = angle
			character.set_rotation(char_rot)
	

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
