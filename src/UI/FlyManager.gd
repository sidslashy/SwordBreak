extends "AbilityInputController.gd"




func triggerAbility():
	GameManager.enable_fly = true
	#print("Ability Triggered!")
	#Override in derived class to set the variable.

func stopAbility():
	GameManager.enable_fly = false
	#print("Ability Ended!")
	#Override in derived class to set the variable.