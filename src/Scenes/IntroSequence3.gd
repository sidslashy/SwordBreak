extends Node2D


var game = preload("res://asset/GameStart.tscn")
var isIntroPlayed = false

onready var key1p = get_node("intro_key_press_1")
onready var key2p = get_node("intro_key_press_2")
onready var anim = get_node("TitleScreen/intro")
onready var kubo = get_node("kubo_dark")
onready var introBtn = get_node("TitleScreen/IntroNode/SelectionButton")


func _ready():
	anim.play("oppeing_title")
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_select") && !isIntroPlayed:
		introBtn.playSelected()

func _on_intro_animation_finished( anim_name ):
	if anim_name == "intro_in":
		kubo.get_node("MoveKeyText").visible = true
		anim.play("intro_interactive")
		kubo.enableMotion()
	if anim_name == "sword_break":
		key2p.play()
		get_tree().change_scene_to(game)
	pass # replace with function body


func _on_anim_animation_finished( anim_name ):
	isIntroPlayed = true
	key1p.play()
	anim.play("intro_in")
	pass # replace with function body
