extends Node

func GetSound(Name: String):
	var Path   = "res://Sounds/" + Name
	var Exists = FileAccess.file_exists(Path)

	return Exists and load(Path) or null


func PlaySound(Name: String):
	var Sound = GetSound(Name)
	if not Sound:
		return
	# var player: AudioStreamPlayer = $AudioStreamPlayer
	# player.stream = Sound
	# player.play()

var b = 0
func test():
	PlaySound("BONE.mp3")
