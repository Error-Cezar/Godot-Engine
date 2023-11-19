extends Node

var currentdelta = 0

var preloader = null
var InputController = null

var offX = 0
var offY = 0

func InitializeModules():
	InputController = Preloader.LoadModule("InputController")

# Called when the node enters the scene tree for the first time.
func _ready():
	Preloader.Initialize()
	InitializeModules()
	var Camera: Camera2D = get_node("Camera2D")

	var bone = preload("res://Sounds/BONE.mp3")
	var clash = preload("res://Sounds/CLASH.mp3")
	var player: AudioStreamPlayer = get_node("Sprite2D").get_node("AudioStreamPlayer")
	print("------------------")
	print("GAME SERVER INIT")
	
	InputController.OnPress(KEY_Z, func():
		player.stream = clash
		player.play()
		print("Z PRESS")
	)

	InputController.OnHold(KEY_Z, func():
		offY += 1
		Camera.offset = Vector2(offX, offY)
	)

	InputController.OnHold(KEY_D, func():
		offX -= 1
		Camera.offset = Vector2(offX, offY)
	)

	InputController.OnHold(KEY_Q, func():
		offX += 1
		Camera.offset = Vector2(offX, offY)
	)

	InputController.OnHold(KEY_S, func():
		offY -= 1
		Camera.offset = Vector2(offX, offY)
	)

	InputController.OnRelease(KEY_Z, func():
		player.stream = bone
		player.play()
		print("Z RELEASE")
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentdelta = delta

func _unhandled_input(event):
	if event is InputEventKey:
		InputController.Check(event)
