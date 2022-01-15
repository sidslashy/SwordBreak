extends "AbilityInputController.gd"



func triggerAbility():
	GameManager.enable_attack = true
	#print("Ability Triggered!")
	#Override in derived class to set the variable.

func stopAbility():
	GameManager.enable_attack = false
	#print("Ability Ended!")
	#Override in derived class to set the variable.