extends RigidBody
export(String) var repaired_by
export(int) var points_given = 100
export(String) var game_manager_path = "../gameManager"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var elem

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func start_repair():
	print("started repairing the item")
	var manager = get_node(game_manager_path)
	manager.add_points(points_given)
	

func finish_repair():
	pass

func _on_ItemPos_body_entered(body):
	print("entered!")
	if body is BaseInteractiveObject and body.get_name() == repaired_by:
		print("IS BASE INTERACTIVE OBJECT!!!")
		print(body.get_name())
		body.disable_char_collision()
		self.start_repair()
		body.get_parent().remove_child(body)
		elem = body
		$Timer.start(1)


func _on_Timer_timeout():
	if elem != null:
		elem.free()
