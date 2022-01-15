extends Sprite

export var note_key = "1"
export var note_row = "1"
onready var timer = get_node("Timer")
onready var sound = get_node("sound")

func _process(delta):
	if Input.is_action_just_pressed("note_"+note_key) && !GameManager.game_over:
		get_parent().get_parent().get_node("Strings").get_node("String"+note_row).pluckString()
		startTimer()
		set_frame(1)
		sound.play()
	pass

func startTimer():
	timer.start()
	pass

func _on_Timer_timeout():
	timer.stop()
	set_frame(0)
	pass 