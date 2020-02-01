extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = Vector3()
var move_speed = 1
var rotation_speed = 2
var gravity = -9.81 * 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	speed = gravity * delta
	move_and_slide(speed, Vector3(0,1,0))
	
	if (Input.is_action_pressed("tecla_a")):
		pass
