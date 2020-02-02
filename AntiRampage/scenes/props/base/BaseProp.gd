tool
extends RigidBody

export(Mesh) var mesh setget mesh_set
export(Material)  var material setget material_set
#export(float) var mass = 1 setget mass_set
## Declare member variables here. Examples:
## var a = 2	
## var b = "text"
#var original_material
#var has_material_changed = false
#
func mesh_set(new_mesh):

	mesh = new_mesh
	if (mesh != null):
		var mesh_instance = $MeshInstance
		mesh_instance.mesh = mesh
		mesh_instance.create_convex_collision()
		var static_body = mesh_instance.get_child(0)
		var collision_shape = static_body.get_child(0)

		if (get_child_count() == 2):
			var old_collision  = get_child(1)
			remove_child(old_collision)
			old_collision.free()
		collision_shape.set_owner(self)
		collision_shape
		static_body.remove_child(collision_shape)
		add_child(collision_shape)
		mesh_instance.remove_child(static_body)
		static_body.free()

#
func material_set(new_material):
	material = new_material
	$MeshInstance.material_override = new_material


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
