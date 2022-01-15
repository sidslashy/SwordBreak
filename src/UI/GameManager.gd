extends Node
# Global variable to check if note is active set to false once note is pressed
# Make it true on timeout of delay timer.


var state_intro = 0

var game_start_state = 1

var state_tutorial_1 = 1 #Tutorial blocks
var state_tutorial_2 = 2 #Tutorial grab
var state_gameplay = 3 # Game

var current_game_state = 0


var note_press_active = true
var ability_active = false
  
var enable_fly = false
var enable_attack = false
var enable_block = false
var sword_collected = false

var monkey_grabbed = false
var beetle_grabbed = false

var is_boss_attacking = false

var game_over = false
var character_died = false

var winSwordFound = false
var winnerSwordID = int(randf()*9)

var game = preload("res://asset/GameStart.tscn")
var retry  = preload("res://src/Scenes/RetryGame.tscn")
var win  = preload("res://src/Scenes/WinGame.tscn")


func resetAllFlags():
	note_press_active = true
	ability_active = false
	enable_fly = false
	enable_attack = false
	enable_block = false
	sword_collected = false
	monkey_grabbed = false
	beetle_grabbed = false
	is_boss_attacking = false
	game_over = false
	character_died = false
	winSwordFound = false
	current_game_state = 0
	randomize()
	winnerSwordID = int(randf()*9)
	print("Winner ID"+str(winnerSwordID))

func characterDied():
	game_over = true
	character_died = true
	get_parent().get_node("GameStart/BossStage/AudioStreamPlayer").stop()
	pass

func notifyGrab():
	var ability =  get_parent().get_node("GameStart/BossStage/AbilityUI/Attack/AbilityBar")
	ability.playNotify()
	pass

func notifyQuake():
	var ability =  get_parent().get_node("GameStart/BossStage/AbilityUI/Block/AbilityBar")
	ability.playNotify()
	pass

func notifyFly():
	#var ability =  get_parent().get_node("GameStart/BossStage/AbilityUI/Block/AbilityBar")
	var flyAnim = get_parent().get_node("GameStart/BossStage/FlyIndicator/anim")
	flyAnim.play("fly_indicator")
	#ability.playNotify()
	pass


func winSwordFound():
	winSwordFound = true
	get_parent().get_node("GameStart/BossStage/AudioStreamPlayer").stop()
	pass
	


func gotoRetry():
	get_tree().change_scene_to(retry)
	resetAllFlags()

func gotoWinner():
	get_tree().change_scene_to(win)
	resetAllFlags()
