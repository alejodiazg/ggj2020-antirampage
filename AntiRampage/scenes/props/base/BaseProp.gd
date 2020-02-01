tool
extends Spatial

export(Mesh) var mesh setget mesh_set
export(PhysicsMaterial) var physic_material setget physic_material_set
export(Material)  var material setget material_set
# Declare member variables here. Examples:
# var a = 2	
# var b = "text"
var original_material
var has_material_changed = false

func mesh_set(new_mesh):
	mesh = new_mesh
	if (mesh != null):
		var mesh_instance = $RigidBody/MeshInstance
		mesh_instance.mesh = mesh
		mesh_instance.create_convex_collision()
		var static_body = mesh_instance.get_child(0)
		var collision_shape = static_body.get_child(0)
		
		if ($RigidBody.get_child_count() == 2):
			var old_collision  = $RigidBody.get_child(1)
			$RigidBody.remove_child(old_collision)
			old_collision.free()
		collision_shape.set_owner(self)
		static_body.remove_child(collision_shape)
		$RigidBody.add_child(collision_shape)
		mesh_instance.remove_child(static_body)
		static_body.free()

func physic_material_set(new_material):
	if !has_material_changed:
		original_material = $RigidBody.physics_material_override
		has_material_changed = true
	
	if new_material == null:
		physic_material = original_material
	else:
		physic_material = new_material
	$RigidBody.physics_material_override = physic_material

func material_set(new_material):
	material = new_material
	$RigidBody/MeshInstance.material_override = new_material

# Called when the node enters the scene tree for the first time.
func _ready():
	if (mesh != null):
		var mesh_instance = $RigidBody/MeshInstance
		mesh_instance.mesh = mesh
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
