extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var anim =  get_node("anim")
var screenChangeAnimPlayed = false


func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if(GameManager.character_died && !screenChangeAnimPlayed):
		screenChangeAnimPlayed = true
		anim.play("fade_red")
	if(GameManager.game_over && !screenChangeAnimPlayed):
		screenChangeAnimPlayed = true
		anim.play("fade_white")
	pass


func _on_anim_animation_finished( anim_name ):
	if anim_name == "fade_red":
		GameManager.gotoRetry()
	if anim_name == "fade_white":
		GameManager.gotoWinner()
	pass # replace with function body
