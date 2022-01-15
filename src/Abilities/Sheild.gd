extends Sprite


onready var anim = get_node("AnimationPlayer")
export var sheild_time = 4

func activate():
	if !anim.is_playing():
		anim.play("sheild_anim")

func deactivate():
	if anim.is_playing():
		anim.stop(true)
	visible = false

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
