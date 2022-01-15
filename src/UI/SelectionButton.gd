extends Node2D

onready var on = get_node("ON")
onready var off = get_node("OFF")
onready var arrow = get_node("SelectionArrow")
onready var anim = get_node("anim")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func selectButton():
	arrow.visible = true

func playSelected():
	anim.play("selected")
