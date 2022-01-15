extends Node

var game = preload("res://asset/GameStart.tscn")
var intro = preload("res://src/Scenes/IntroSequence3.tscn")


func _input(event):
	if Input.is_action_pressed("ui_select"):
		GameManager.game_start_state = 3
		get_tree().change_scene_to(game)




