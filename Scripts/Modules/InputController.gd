extends Node

var InputFunctions = {
	
}

var ReleaseFunctions = {
	
}

var HoldFunctions = {
	
}

var preloader
var InputController

func OnPress(Key, Execute):
	if not Key in InputFunctions: InputFunctions[Key] = []
	InputFunctions[Key].append(Execute)
	

func OnRelease(Key, Execute):
	if not Key in ReleaseFunctions: ReleaseFunctions[Key] = []
	ReleaseFunctions[Key].append(Execute)


func OnHold(Key, Execute):
	if not Key in HoldFunctions: HoldFunctions[Key] = []
	HoldFunctions[Key].append(Execute)

func Check(event: InputEventKey):
	var Keycode = event.keycode
	var Hold    = event.is_echo()
	var Pressed = event.pressed
	
	if (Hold and Pressed) and Keycode in HoldFunctions:
		for f in HoldFunctions[Keycode]:
			f.call()
			
	if (not Hold and Pressed) and Keycode in InputFunctions:
		InputController = Preloader.LoadModule("SoundController")
		
		InputController.test()
		for f in InputFunctions[Keycode]:
			f.call()
			
	if ((not Hold) and (not Pressed)) and Keycode in ReleaseFunctions:
		for f in ReleaseFunctions[Keycode]:
			f.call()
