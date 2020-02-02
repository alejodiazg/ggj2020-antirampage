extends KinematicBody

var speed = Vector3()
var gravity = -9.81
var move_spd = 300
var rotation_spd = 1
var is_grabbing = false
var is_moveable = true
var character
var camera
var rotating = false
var prev_rot_z
var prev_rot_x
const SPEED = 40
const ACCELERATION = 10
const DE_ACCELERATION = 10

func _ready():
	character = get_node(".")
	
	get_node("Animadino/AnimationPlayer").get_animation("default").set_loop(true)
	get_node("Animadino/AnimationPlayer").play("default")
	pass 
		
func _physics_process(delta):
	input_processing(delta)
	#move_and_slide(speed, Vector3(0,1,0))
	
func _input(event):
   # Mouse in viewport coordinates
	if (rotating):
		if event is InputEventMouseMotion:
			var mouse = event.position
			rotate_axis(mouse)



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
		
		if (!rotating):
			speed.y += delta * gravity
		
		var hv = speed
		hv.y = 0
		
		var new_pos = dir * SPEED
		var accel = DE_ACCELERATION
		
		if (dir.dot(hv) > 0):
			accel = ACCELERATION
			
		hv = hv.linear_interpolate(new_pos, accel * delta)
		
		speed.x = hv.x
		speed.z = hv.z
				
		speed = move_and_slide(speed, Vector3(0,1,0))	
		
		if is_moving:
			
			get_node("Animadino/AnimationPlayer").play("default")
			# Rotate the player to direction
			var angle = atan2(hv.x, hv.z)
			
			var char_rot = character.get_rotation()
			
			char_rot.y = angle
			character.set_rotation(char_rot)
		else:
			get_node("Animadino/AnimationPlayer").stop()
	
	
	if (Input.is_action_just_pressed("rotar")):
		rotating = true
		#is_moveable = false
		prev_rot_z = rotation_degrees.z
		prev_rot_x = rotation_degrees.x
		
	if (Input.is_action_just_released("rotar")):
		rotating = false
		#is_moveable = true
		rotation_degrees.z = prev_rot_z
		rotation_degrees.x = prev_rot_x

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

func rotate_axis(mouse):
	var cameraObj = get_node("target/Camera")
	var screenPoint = cameraObj.unproject_position(get_node('Animadino').get_global_transform().origin)
	
	var offset = Vector2(mouse.x - screenPoint.x, mouse.y - screenPoint.y)
	
	var anglez = deg2rad(atan2(offset.y, offset.x))
	

	var anglex = deg2rad(mouse.x - screenPoint.x - rotation.x);
	var angley = deg2rad(mouse.y - screenPoint.y - rotation.y);
	
	if (abs(rotation_degrees.x) < 45 || abs(rotation_degrees.x) > 45 &&  abs(rotation_degrees.x + angley) < 45):
		rotation_degrees.x += angley
	
	if (abs(rotation_degrees.z) < 45 || abs(rotation_degrees.z) > 45 &&  abs(rotation_degrees.z + anglex) < 45):
		rotation_degrees.z += anglex
