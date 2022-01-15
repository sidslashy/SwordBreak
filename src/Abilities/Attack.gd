extends Sprite

onready var anim = get_node("anim")

func _ready():

	pass

func attack():
	if !anim.is_playing():
		visible = true
		if GameManager.beetle_grabbed:
			anim.play("attack_left_new")
		else:
			anim.play("attack_right_new")
			#flip_h = false
			#end.flip_h = false
		

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_anim_animation_finished( anim_name ):
	if anim_name == "attack_left_new":
		anim.play("attack_left_end")
		get_parent().attackHitComplete()
	if anim_name == "attack_left_end":
		get_parent().attackAnimComplete()
	if anim_name == "attack_right_new":
		anim.play("attack_right_end")
		get_parent().attackHitComplete()
	if anim_name == "attack_right_end":
		get_parent().attackAnimComplete()
	pass # replace with function body
