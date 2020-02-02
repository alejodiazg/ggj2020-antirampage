extends Node

var time_left = 60
var points = 5000
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	print("hole")
	timer = Timer.new()
	timer.set_wait_time(time_left)
	timer.connect("timeout",self,"_on_timer_timeout") 
	#timeout is what says in docs, in signals
	#self is who respond to the callback
	#_on_timer_timeout is the callback, can have any name
	add_child(timer) #to process
	timer.start() #to start

	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(timer.time_left)
	pass
	
func _on_timer_timeout():
	print("se termino el tiempo BRO")
   #your_timer_stuff()
