extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var grabbed
var on_area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.scancode == KEY_E and not event.echo:
		if on_area and not grabbed:
			print("GRABBED ITEM!")
			grabbed = on_area
			if grabbed.has_method("picked_up"):
					grabbed.picked_up(self)
		elif on_area and grabbed:
			print("I THREW IT ON THE GROUND!!!")
			grabbed.droped()
			grabbed = null
		else:
			print("U IDIOT!!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	print("on body enter was triggered")
	if body is BaseInteractiveObject:
		print("IS BASE INTERACTIVE OBJECT!!!")
		body.disable_char_collision()
		if on_area == null:
			on_area = body


# warning-ignore:unused_argument
func _on_Area_body_exited(body):
	if body is BaseInteractiveObject:
		body.enable_char_collision()
		if body == on_area:
			on_area = null
