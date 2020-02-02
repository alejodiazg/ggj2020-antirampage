extends Node

var bgm_menu = preload("res://assets/sounds/menusaurus.ogg")
var bgm_game = preload("res://assets/sounds/techrex.ogg")

var time_left = 120
var points = 5000
var timer
var character
var playButton
var MainMenu
var Logo
var GUI

var fixers
var tofix
var actual_fixer
var actual_tofix
var fixer1
var actual_fixer_logo 
var actual_fixer_texture_gui
onready var number_label 
onready var points_label 
var bgm_player

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().get_current_scene()
	bgm_player = root.get_node("AudioStreamPlayer")
	GUI = root.get_node("GUI")
	number_label = GUI.get_node("TimerLabel")
	points_label = GUI.get_node("PointsLabel")
	MainMenu = root.get_node("MainMenu/Control")
	Logo = root.get_node("MainMenu/Logo")
	playButton = root.get_node("MainMenu/Control/VBoxContainer/PlayButton")
	character = root.get_node("level/dino")
	fixer1 = root.get_node("level/Fixer1")
	actual_fixer_texture_gui = GUI.get_node("tofix_texture")
	fixers = [fixer1]
	
	updateFixer(0)

	playButton.connect("pressed",self,"game_start")
	character.is_moveable = false
	add_child(timer) #to process
	#timer.start() #to start



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(number_label)
	number_label.set_text(str(int(timer.time_left)))
	points_label.set_text(str(int(points)))
	pass

func add_points(new_points):
	points += new_points

func _on_timer_timeout():
	timer.stop()
	character.is_moveable = false
	GUI.hide()
	#game_over_screen()
	print("se termino el tiempo BRO")
   #your_timer_stuff()

func game_start():
	character.is_moveable = true
	GUI.show()
	MainMenu.hide()
	Logo.hide()
	timer.start()
	bgm_player.stop()
	bgm_player.stream = bgm_game
	bgm_player.play()

	
func updateFixer(i):
	actual_fixer = fixers[i]
	actual_fixer_logo = actual_fixer.icon
	actual_fixer_texture_gui.set_texture(actual_fixer_logo)
	actual_fixer_texture_gui.set_size(Vector2(1,1))
