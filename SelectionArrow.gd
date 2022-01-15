extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var anim = null

func _ready():
	anim = get_node("anim")
	anim.play("arrow_anim")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
