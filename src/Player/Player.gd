extends KinematicBody2D


var motion = Vector2()
const UP = Vector2(0,-1)
export var JUMP_HEIGHT = 2000
export var MOVE_SPEED = 200
export var FLY_SPEED = 400
export var GRAVITY = 1000


var canFly
var isAttacking
var enableBlock

var playerAttacked = false

var attack = null
var ATT = preload("res://src/Abilities/Attack.tscn")
#onready var attack = get_node("Attack")
onready var camera = get_node("camera")
onready var wings = get_node("wings")
onready var sheild = get_node("Sheild")
onready var flySound = get_node("wing_sound")
onready var swordPullSound = get_node("sword_pull")
onready var anim = get_node("anim")
onready var attackPosition = get_node("attackPositon")
onready var audio_hit = get_node("audio_hit")



var isFlyAnimActive = false

var isFirstFly = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _physics_process(delta):
	canFly = GameManager.enable_fly
	isAttacking = GameManager.enable_attack
	enableBlock = GameManager.enable_block
	
	if GameManager.game_start_state != 3 && isFirstFly && canFly:
		isFirstFly = false
		GameManager.notifyFly()
	
	if(canFly):
		#wings.visible = true
		if !isFlyAnimActive:
			isFlyAnimActive = true
			anim.play("fly_start")
		if !flySound.playing:
			flySound.play()
	else:
		if isFlyAnimActive:
			isFlyAnimActive = false
			anim.play("idle")
			
		wings.visible = false
		flySound.stop()
	
	if(enableBlock):
		sheild.activate()
	else:
		sheild.deactivate()
	
	var currentMotion = Vector2()
	if Input.is_action_pressed("ui_right"):
		currentMotion.x = MOVE_SPEED
	elif Input.is_action_pressed("ui_left"):
		currentMotion.x = -MOVE_SPEED
	
	if abs(currentMotion.x) > 0:
		if anim.current_animation != "move" && !isFlyAnimActive:
			anim.play("move")
	else:
		if anim.current_animation != "idle" && !isFlyAnimActive && anim.current_animation != "hit":
			anim.play("idle")
	
	motion.x = currentMotion.x
	
	
	motion.y += GRAVITY*delta
	#if is_on_floor() && Input.is_action_just_pressed("ui_up") && !canFly:
	#	motion.y = -JUMP_HEIGHT
	if canFly && Input.is_action_pressed("ui_up"):
		motion.y = -FLY_SPEED
	if canFly && is_on_floor():
		motion.y = 0
	
	if is_on_floor():
		GameManager.sword_collected = false
	
	if !GameManager.winSwordFound:
		motion = move_and_slide(motion,UP)
	pass

func _process(delta):
	if(isAttacking):
		attackBoss()
		#attackEnd()

func attackBoss():
	print("Attack Triggered")
	if !playerAttacked:
		GameManager.enable_attack = false
		attack = ATT.instance()
		attack.position = attackPosition.position
		add_child(attack)
		attack.visible = true
		attack.attack()
	pass

func attackHitComplete():
	get_parent().get_node("BossStage").get_node("Boss").onAttackHit()
	playerAttacked = false
func attackAnimComplete():
	attack.queue_free()


func attackEnd():
	#if(attack != null):
		#attack.queue_free()
		#attack = null
	pass

func playHit():
	anim.play("hit")
	audio_hit.play()



func _on_anim_animation_finished( anim_name ):
	if anim_name == "hit":
		anim.play("idle")
	pass # replace with function body
