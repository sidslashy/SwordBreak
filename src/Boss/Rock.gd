extends Area2D


export var ROCK_SPEED = 1500

onready var anim = get_node("AnimationPlayer")
onready var collider = get_node("collider")

func _ready():
	set_physics_process(false)
	pass

func _physics_process(delta):
	position.y += ROCK_SPEED * delta
	pass


func dropRock():
	set_physics_process(true)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func playDestroyAnim():
	set_physics_process(false)
	anim.play("rock_break")
	pass

func _on_Rock_area_entered( area ):
	#print("Rock Area "+area.name)
	if GameManager.winSwordFound:
		queue_free()
	if(area.name == "sheild" && GameManager.enable_block):
		collider.queue_free()
		playDestroyAnim()
	elif(area.name == "Monkey" || area.name == "Beetle" ):
		area.get_node("HealthBar").hitAnim()
		area.get_node("anim").play("hit")
		area.get_node("audio_hit").play()
		collider.queue_free()
		playDestroyAnim()
	elif(area.name == "Kubo"):
		area.get_parent().playHit()
		GameManager.enable_fly = false
		#area.get_node("anim").play("hit")
		collider.queue_free()
		playDestroyAnim()
	pass # replace with function body


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # replace with function body


func _on_AnimationPlayer_animation_finished( anim_name ):
	if(anim_name == "rock_break"):
		queue_free()
	pass # replace with function body
