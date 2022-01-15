extends Area2D

onready var sheild = get_node("Sheild")
var anim = null
var audio = null
var audio_hit = null

func _ready():
	anim = get_node("anim")
	audio = get_node("audio")
	audio_hit = get_node("audio_hit")
	anim.play("idle")
	pass

func _physics_process(delta):
	if GameManager.enable_block:
		sheild.activate()
	else:
		sheild.deactivate()


func isGrabbed():
	visible = false
	audio_hit.play()
	anim.stop()

func isDropped():
	visible = true
	anim.play("idle")


func _on_anim_animation_finished( anim_name ):
	if anim_name == "hit":
		anim.play("idle")
	if anim_name == "idle":
		anim.play("idle")
	pass # replace with function body



func _on_anim_animation_started( anim_name ):
	if anim_name == "idle":
		audio.play()
	pass # replace with function body
