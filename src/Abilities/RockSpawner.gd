extends Node2D

export var ROCK = preload("res://src/Boss/Rock.tscn")
onready var timer = get_node("Timer")
onready var positon = get_node("Position2D")
export var rock_spawn_time = 1

func _ready():
	#timer.wait_time = rock_spawn_time
	#timer.start()
	pass


func _on_Timer_timeout():
	dropRock()
	pass # replace with function body


func dropRock():
	var rock = ROCK.instance()
	get_parent().add_child(rock)
	rock.position = get_node("Position2D").global_position
	rock.dropRock()