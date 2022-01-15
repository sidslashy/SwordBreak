extends Sprite

onready var anim = get_node("anim")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func pluckString():
	anim.play("pluck")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
