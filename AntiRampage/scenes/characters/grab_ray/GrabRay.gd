extends RayCast


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var grabbed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		if self.enabled and Input.is_action_pressed("pick_up"):
			if is_colliding():
				var body = get_collider()
				if body is BaseInteractiveObject:
						print("IS BASE INTERACTIVE OBJECT!!!")
						body.disable_char_collision()
						grabbed = body
						body.picked_up(self)
						self.enabled = false
		elif grabbed != null:
			grabbed.droped()
			grabbed.enable_char_collision()
			grabbed = null
			self.enabled = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
#	if is_colliding():
#		print("is colliding")
