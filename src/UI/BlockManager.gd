extends "AbilityInputController.gd"




func triggerAbility():
	GameManager.enable_block = true
	print("Ability Triggered!")
	#Override in derived class to set the variable.

func stopAbility():
	print("Ability Ended!")
	GameManager.enable_block = false
	#Override in derived class to set the variable.

