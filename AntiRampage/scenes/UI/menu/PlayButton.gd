extends TextureButton

export(NodePath) var animation_player_path
var animation_player
var ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = get_node(animation_player_path)

func _input(event):
	if (!ready && Input.is_action_just_pressed("pick_up")):
		var anim = animation_player.current_animation
		if (anim):
			var length = animation_player.get_animation(anim).length
			animation_player.seek(length)
		ready = true

func _on_PlayButton_pressed():
	print("pres")
	pass
