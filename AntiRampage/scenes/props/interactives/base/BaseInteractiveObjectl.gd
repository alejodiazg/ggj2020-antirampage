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
var old_rotation

# Called when the node enters the scene tree for the first time.
func _ready():
	original_parent = get_parent()
	pass # Replace with function body.

func get_name():
	return object_name

func _process(_delta):
	if holder != null:
		var basis = Quat(holder.global_transform.basis.get_euler() + old_rotation)
		var nuevo_transform = Transform(basis)
		self.global_transform = nuevo_transform
		self.translation = holder.get_global_transform().origin
#		self.global_transform = holder.get_global_transform()
#		self.rotation = holder.rotation + old_rotation

func picked_up(parent):
	self.set_mode(1)
	old_rotation = global_transform.basis.get_euler()
#	old_rotation = self.rotation
	holder = parent
	
func disable_char_collision():
	self.set_collision_mask_bit(1,false)
	self.set_collision_layer_bit(1,false)
	for child in get_children():
		if child is CollisionShape:
			child.disabled = true

func enable_char_collision():
	self.set_collision_mask_bit(1,true)
	self.set_collision_layer_bit(1,true)
	for child in get_children():
		if child is CollisionShape:
			child.disabled = false
	
func droped():
	self.set_mode(0)
	holder = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
