extends Node

var scriptPath = "res://Scripts/"
var ModulesPath = scriptPath + "Modules/"

var Assets = {
	# "InputController" = load(ModulesPath + "InputController.gd").new(),
	# "SoundController" = load(ModulesPath + "SoundController.gd").new(),
}

func Debug(m):
	print("[PRELOADER] => ", m)

func OpenDir(Path: String):
	var Files = []
	var dir = DirAccess.open(Path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if not file:
			dir.list_dir_end()
			break
		elif not file.begins_with("."):
			Files.append(Path + file)
	return Files

func Initialize():
	Debug("Initializing Assets")
	var Files = OpenDir(ModulesPath)
	for key in Files:
		Debug("Initializing " + key.get_basename().get_file())
		Assets[key.get_basename().get_file()] = load(key).new()

func LoadModule(Name: String):
	Debug("Loading Module " + Name)
	var Asset = Assets[Name]
	print(Assets)
	print(Asset)
	if !Asset: Debug("No Module Found"); return false
	
	return Asset
