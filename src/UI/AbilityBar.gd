extends Node2D

signal trigger_complete
signal cooldown_complete
signal ability_timeout

onready var anim = get_node("anim")
onready var notifier = get_node("notifierPlayer")
onready var cooldown = get_node("cooldown")
export var cooldown_speed = 1.0
export var ability_duration = 1.0


func playNotify():
	if !notifier.is_playing():
		notifier.play("notifier")
	pass

func playTriggerAnim():
	emit_signal("trigger_complete")
	startAbilityTimer()

func playCoolDownAnim():
	cooldown.visible = true
	anim.playback_speed = 1/cooldown_speed
	anim.play("cooldown")


func startAbilityTimer():
	anim.playback_speed = 1/ability_duration
	anim.play("skill_duration")

func _on_animation_finished( anim_name ):
	if anim_name == "skill_duration":
		emit_signal("ability_timeout")
		playCoolDownAnim()
	elif anim_name == "cooldown":
		cooldown.visible = false
		anim.playback_speed = 1.0
		emit_signal("cooldown_complete")

