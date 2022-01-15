extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var motion = Vector2()
var SPEED = 100
onready var moveText = get_node("MoveKeyText")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	disableMotion()
	pass

func enableMotion():
	set_physics_process(true)

func disableMotion():
	set_physics_process(false)


func _physics_process(delta):
	motion = Vector2()
	if Input.is_action_pressed("ui_up"):
		motion.y = -SPEED
		moveText.visible = false
	if Input.is_action_pressed("ui_down"):
		motion.y = SPEED
		moveText.visible = false
	if Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		moveText.visible = false
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		moveText.visible = false
	move_and_slide(motion)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
