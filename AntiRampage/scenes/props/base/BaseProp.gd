tool
extends RigidBody

export(Mesh) var mesh setget mesh_set
export(Material)  var material setget material_set
export(bool) var generate_collision = true


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
	var instance = $MeshInstance
	if instance == null:
		return
	instance.material_override = new_material

func _integrate_forces(delta):
	set_friction(1)
	set_bounce(0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
