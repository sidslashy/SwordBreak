extends Node2D

# random function
var origin = null
var test = []
var lastAttack = 0

# Tutorial states.
var state1 = [1,1]
var state2 = [2]
var state3 = [1,1,1,1,1,1,2,2,3,3]

var isQuakeTriggered = false
var isGrabTriggered = false



onready var anim = get_node("boss_anim")
onready var timerMonkey = get_node("HealthBarMonkey")
onready var timerBeetle = get_node("HealthBarBeetle")
onready var rock1 = get_node("RockSpawner")
onready var rock2 = get_node("RockSpawner2")
onready var rock3 = get_node("RockSpawner3")
onready var audio_quake = get_node("audio_quake")
onready var audio_grab = get_node("audio_dry_grab")
var attackTimer = null

signal game_state_changed



func _ready():
	attackTimer = get_node("AttackTimer")
	if GameManager.game_start_state == 1:
 		print("State 1 Start")
 		origin = state1.duplicate()
 		GameManager.current_game_state = 1
	elif GameManager.game_start_state == 2:
		origin = state2.duplicate()
		GameManager.current_game_state = 2
		print("State 2 Start")
	elif GameManager.game_start_state == 3:
		GameManager.current_game_state = 3
		print("State 3 Start")
	attackTimer.start()
	pass

func generateAttack():
	#print("Attack Gen")
	if !GameManager.is_boss_attacking:
		var index
		var item

		if GameManager.current_game_state == 1:
			if(len(origin) > 0):
				item = origin[0]
				origin.remove(0)
			else:
				GameManager.current_game_state = 2
				origin = state2.duplicate()
				emit_signal("game_state_changed")
		elif GameManager.current_game_state == 2:
			if(len(origin) > 0):
				item = origin[0]
				origin.remove(0)
			else:
				GameManager.current_game_state = 3
				emit_signal("game_state_changed")
		elif GameManager.current_game_state == 3:
			randomize()
			if(len(test) == 0):
				test = state3.duplicate()
			index = int(randf()*len(test))
			item = test[index]
			test.remove(index)
		if(item == 1):
			if !isQuakeTriggered && GameManager.current_game_state == 1:
				isQuakeTriggered = true
				GameManager.notifyQuake()
			anim.play("quake")
			audio_quake.play()
			rock1.dropRock()
			rock2.dropRock()
			rock3.dropRock()
			GameManager.is_boss_attacking = true
			attackTimer.stop()
		elif(item == 2):
			anim.play("grab_anticipation_monkey_1")
			GameManager.is_boss_attacking = true
			attackTimer.stop()
		elif(item == 3):
			anim.play("grab_anticipation_beetle_1")
			GameManager.is_boss_attacking = true
			attackTimer.stop()
	pass


func onAttackHit():
	if GameManager.monkey_grabbed:
		anim.stop()
		anim.play("grab_end_monkey")
		timerMonkey.stopGrabTimer()
		GameManager.monkey_grabbed = false
	if GameManager.beetle_grabbed:
		anim.stop()
		anim.play("grab_end_beetle")
		timerBeetle.stopGrabTimer()
		GameManager.beetle_grabbed = false


func _on_boss_anim_animation_finished( anim_name ):
	#if skellie grabs monkey 
	if anim_name == "grab_anticipation_monkey_1":
		anim.play("grab_anticipation_monkey_2")
		get_parent().get_parent().get_node("Monkey").isGrabbed()
	if anim_name == "grab_anticipation_monkey_2":
		if(!isGrabTriggered && GameManager.current_game_state == 2): #Condition for tutorial
			isGrabTriggered
			GameManager.notifyGrab()
		GameManager.monkey_grabbed = true
		anim.play("grab_start_monkey")
		timerMonkey.startGrabTimer()
		audio_grab.play()
	if anim_name == "grab_end_monkey":
		get_parent().get_parent().get_node("Monkey").isDropped()
		anim.play("boss_idle")
		GameManager.is_boss_attacking = false
		attackTimer.start()
	
	#if skellie grabs beetle
	if anim_name == "grab_anticipation_beetle_1":
		anim.play("grab_anticipation_beetle_2")
		get_parent().get_parent().get_node("Beetle").isGrabbed()
	if anim_name == "grab_anticipation_beetle_2":
		GameManager.beetle_grabbed = true
		anim.play("grab_start_beetle")
		timerBeetle.startGrabTimer()
		audio_grab.play()
	if anim_name == "grab_end_beetle":
		get_parent().get_parent().get_node("Beetle").isDropped()
		anim.play("boss_idle",0.3)
		GameManager.is_boss_attacking = false
		attackTimer.start()
	if anim_name == "quake":
		anim.play("boss_idle",0.5)
		GameManager.is_boss_attacking = false
		attackTimer.start()
	
	pass # replace with function body



func _on_AttackTimer_timeout():
	generateAttack()
	pass # replace with function body
