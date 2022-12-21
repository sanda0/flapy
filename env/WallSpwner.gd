extends Node2D

signal wall_created(wall)
onready var timer = $Timer
var walls = preload("res://env/walls.tscn")

func _ready():
	randomize()




func _on_Timer_timeout():
	spawn_walls()

func spawn_walls():
	var wall = walls.instance()
	add_child(wall)
	wall.position.y = rand_range(300,500)
	#print(wall.position.y)
	wall.get_node("wall").position.y = rand_range(75,100)
	wall.get_node("wall2").position.y = rand_range(-75,-100)
	
	emit_signal("wall_created",wall)
	

func start():
	#print("start")
	timer.start()

func stop():
	#print("stop")
	timer.stop()
