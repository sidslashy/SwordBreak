extends Area2D

onready var collider = get_node("collider")
onready var anim = get_node("anim")
onready var highlight = get_node("highlight")
onready var sword_break = get_node("sword_break")
onready var win_music = get_node("win_music")
export var id = 0
var swordIndicated = false
var swordCanBeCollected = false

func _ready():
	
	pass


func _on_Sword_area_entered( area ):
	if(area.name == "Kubo_Sword"):
		#
		swordCanBeCollected = true
		if !swordIndicated && !GameManager.sword_collected:
			highlight.visible = true
			swordIndicated = true
		# To ensure only 1 sword collected in each flight
		#queue_free() # Add some animations
	pass # replace with function body

func _input(event):
	if Input.is_action_just_pressed("ui_select") && !GameManager.sword_collected:
		if(swordIndicated):
			GameManager.enable_fly = false
			GameManager.sword_collected = true
			highlight.visible = false
			if GameManager.winnerSwordID != id:
				anim.play("sword_break")
				sword_break.play()
			else:
				GameManager.winSwordFound()
				anim.play("sword_found")
				win_music.play()
				



func _on_Sword_area_exited( area ):
	if(area.name == "Kubo_Sword"):
		highlight.visible = false
		swordCanBeCollected = false
		swordIndicated = false
	pass # replace with function body


func _on_anim_animation_finished( anim_name ):
	if anim_name == "sword_break":
		queue_free()
	if anim_name == "sword_found":
		GameManager.game_over = true
	pass # replace with function body
