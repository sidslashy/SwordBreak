extends Node2D

var currentActiveIndex = 0
var noteList = []  # Populate this with all the notes in orderplayed
var abilityActive = false
export var abilityUnlockState = 1

onready var abilityBar = get_node("AbilityBar")

func _ready():
	updateNoteList()
	setVisibility()
	pass

func setVisibility():
	if GameManager.game_start_state >= abilityUnlockState:
		visible = true
	else:
		visible = false

func updateNoteList():
	var children = get_children()
	for i in children:
		if i.name.find("AbilityNote") != -1:
			noteList.push_back(i)
			#i.setNoteKey(str(int(randf()*9)+1))
	pass


func playStateUpdateAnim():
	if GameManager.current_game_state == abilityUnlockState:
		visible = true
		#abilityBar.playNotify()
	pass

func updateNoteKeys():
	#var children = get_children()
	#for i in children:
	#	if i.name.find("AbilityNote") != -1:
	#		i.setNoteKey(str(int(randf()*9)+1))
	pass


func _input(event):
	# Check if a note is pressed
	if GameManager.current_game_state >= abilityUnlockState:
		if !abilityActive:
			var noteKey = 0
			for i in range(1,10):
				var x = String(i)
				if Input.is_action_just_pressed("note_"+x):
					noteKey = int(x)
			
			if (noteKey > 0):
				if noteKey == int(noteList[currentActiveIndex].note_key):
					noteList[currentActiveIndex].setNote()
					currentActiveIndex+=1
					if(currentActiveIndex == noteList.size()):
						 # Reset it after animation
						abilityActive = true
						abilityBar.playTriggerAnim()
						triggerAbility()
				else:
					resetAllNotes()

func triggerAbility():
	print("Ability Triggered!")
	#Override in derived class to set the variable.

func stopAbility():
	print("Ability Ended!")
	#Override in derived class to set the variable.


func resetAllNotes():
	#print("Reset All Notes")
	for i in noteList:
		i.resetNote()
	currentActiveIndex = 0

func _on_AbilityNote_note_pressed(data):
	var prevNote = currentActiveIndex
	currentActiveIndex = data[0]
	if(prevNote+1 == currentActiveIndex):
		data[1].set_frame(1)
	else:
		#Note sequence broken hence we reset it.
		data[1].set_frame(0)
		currentActiveIndex = 0
	pass


func _on_AbilityNote_note_expired(data):
	if(currentActiveIndex <= data[0]):
		resetAllNotes()
	pass # replace with function body


func _on_AbilityBar_trigger_complete():
	pass # replace with function body

func _on_AbilityBar_cooldown_complete():
	abilityActive = false
	updateNoteKeys()
	resetAllNotes()
	pass # replace with function body

func _on_AbilityBar_ability_timeout():
	stopAbility()
	pass # replace with function body