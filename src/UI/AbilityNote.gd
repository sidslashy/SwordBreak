extends Sprite

export var note_key = "1"
export var note_index = 0
onready var timer = get_node("Timer")
var lable
var noteActive = false
signal note_pressed
signal note_expired



func _ready():
	lable = get_node("Label")
	lable.text = note_key

func setNoteKey(key):
	note_key = key
	lable.text = note_key

func setNote():
	if  !noteActive:
		timer.start()
		set_frame(1)
	pass

func _on_Timer_timeout():
	timer.stop()
	emit_signal("note_expired",[note_index])
	pass

func resetNote():
	set_frame(0)
	noteActive = false
