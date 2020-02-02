tool
extends RigidBody

var fall1 = preload("res://assets/sounds/fall-comic.ogg")
var fall2 = preload("res://assets/sounds/fall-glass.ogg")
var fall3 = preload("res://assets/sounds/fall-heavy.ogg")
var fall4 = preload("res://assets/sounds/fall-metal.ogg")
var fall5 = preload("res://assets/sounds/fall-small.ogg")
var fall6 = preload("res://assets/sounds/fall-small2.ogg")
var fall7 = preload("res://assets/sounds/fall-small3.ogg")
var fall8 = preload("res://assets/sounds/fall-thud.ogg")
var fall9 = preload("res://assets/sounds/fall-thud2.ogg")

export(Mesh) var mesh setget mesh_set
export(Material)  var material setget material_set
export(bool) var generate_collision = true

onready var sfx_player = $AudioStreamPlayer3D

func _ready():
	gravity_scale = 2

func mesh_set(new_mesh):
	mesh = new_mesh
	if (mesh != null):
		var mesh_instance = $MeshInstance
		if mesh_instance == null:
			return
		mesh_instance.mesh = mesh
		if generate_collision:
			mesh_instance.create_convex_collision()

			var static_body = mesh_instance.get_child(0)
			var collision_shape = static_body.get_child(0)

			if (get_child_count() == 2):
				for child in get_children():
					if child is CollisionShape:
						remove_child(child)
						child.free()
			collision_shape.set_owner(self)
			static_body.remove_child(collision_shape)
			add_child(collision_shape)
			mesh_instance.remove_child(static_body)
			static_body.free()

#
func material_set(new_material):
	material = new_material
	var instance = $MeshInstance
	if instance == null:
		return
	instance.material_override = new_material

func _on_RigidBody_body_entered(body):
	print(body)
