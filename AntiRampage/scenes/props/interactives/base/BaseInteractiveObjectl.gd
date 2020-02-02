tool
class_name BaseInteractiveObject
extends "res://scenes/props/base/BaseProp.gd"

export(String) var object_name
export(ImageTexture) var icon

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var original_parent
var holder

# Called when the node enters the scene tree for the first time.
func _ready():
	original_parent = get_parent()
	pass # Replace with function body.

func get_name():
	return object_name

func _process(_delta):
	if holder != null:
		self.translation = holder.get_global_transform().origin

func picked_up(parent):
	print("I WAS PICKED UP")
	self.set_mode(1)
	holder = parent
	
func disable_char_collision():
	print("disabled the collision with the dinasour")
	self.set_collision_mask_bit(1,false)
	self.set_collision_layer_bit(1,false)
	var shape: CollisionShape = get_child(1)
	shape.disabled = true

func enable_char_collision():
	print("enabled the collition with the dyno")
	self.set_collision_mask_bit(1,true)
	self.set_collision_layer_bit(1,true)
	var shape: CollisionShape = get_child(1)
	shape.disabled = false
	
func droped():
	print("SET DROPED FROM BASE INTERACTIVE")
	self.set_mode(0)
	holder = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
