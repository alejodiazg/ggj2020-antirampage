extends Node

var time_left = 60
var points = 0
var timer
onready var number_label 
onready var points_label 
# Called when the node enters the scene tree for the first time.
func _ready():
	number_label = get_node("GUI/TimerLabel")
	points_label = get_node("GUI/PointsLabel")
	timer = Timer.new()
	timer.set_wait_time(time_left)
	timer.connect("timeout",self,"_on_timer_timeout") 
	
	add_child(timer) #to process
	timer.start() #to start



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(number_label)
	number_label.set_text(str(int(timer.time_left)))
	points_label.set_text(str(int(points)))
	pass

func add_points(new_points):
	points += new_points

func _on_timer_timeout():
	print("se termino el tiempo BRO")
   #your_timer_stuff()
