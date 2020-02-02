extends CollisionShape

var agarrar = true
var object 

func grab_object():
	if(Input.is_action_pressed("agarrar")):
		var grabbed_object = object.instance()
		get_tree().get_nodes_in_group("manos")[0].add_child(grabbed_object)
		grabbed_object.translation = get_node("manos")


