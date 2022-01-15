extends Sprite

onready var anim = get_node("anim")
onready var death = get_node("death")
var hitCount = 1
export var GrabDuration = 6

func _ready():
	pass

func startGrabTimer():
	visible = true
	anim.playback_speed = 60/GrabDuration
	anim.play("grabTimer")

func stopGrabTimer():
	anim.stop(true)
	visible = false


func hitAnim():
	print("Playing Hit")
	anim.play("hit_"+str(hitCount))

func _on_anim_animation_finished( anim_name ):
	
	if anim_name == "hit_1" || anim_name == "hit_2":
		hitCount+=1
	if anim_name == "grabTimer" || anim_name == "hit_3":
		visible = false
		if !GameManager.winSwordFound:
			death.play()
			GameManager.characterDied()
		#print("Character Died GameOver")
	pass # replace with function body
