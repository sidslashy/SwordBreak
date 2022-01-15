extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var isKuboNear = false
var isSwordBreakTriggered = false
var isIndicatorPlayed = false
onready var space = get_node("SPACE")
onready var anim = get_parent().get_node("TitleScreen/intro")
onready var indi_anim = get_parent().get_node("Indicator/anim")
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if Input.is_action_just_pressed("ui_select") && isKuboNear && !isSwordBreakTriggered:
		isSwordBreakTriggered = true
		space.visible = false
		anim.play("sword_break")

func _on_IntroSword_area_entered( area ):
	print(area.name)
	if area.name == "Kubo":
		isKuboNear = true
		space.visible = true
		if !isIndicatorPlayed:
			isIndicatorPlayed = true
			indi_anim.play("indication_anim")
		
	pass # replace with function body


func _on_IntroSword_area_exited( area ):
	print(area.name)
	if area.name == "Kubo":
		isKuboNear = false
		space.visible = false
	pass # replace with function body
