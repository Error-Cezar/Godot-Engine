extends Node

var currentdelta = 0

var InputController  = null
var PlayerController = null

var offX = 0
var offY = 0

func InitializeModules():
	InputController  = Frameworks.LoadModule("InputController")
	PlayerController = Frameworks.LoadModule("PlayerController")

# Called when the node enters the scene tree for the first time.
func _ready():
	Frameworks.Initialize()
	InitializeModules()
	var Camera: Camera2D = get_node("Camera2D")

	PlayerController.Register(get_node("CharacterBody2D"))

	# var bone = preload("res://Sounds/BONE.mp3")
	# var clash = preload("res://Sounds/CLASH.mp3")
	print("------------------")
	print("GAME SERVER INIT")
	
	InputController.OnPress(KEY_Z, func():
		PlayerController.MoveY = 1
	)
	InputController.OnRelease(KEY_Z, func():
		PlayerController.MoveY = 0
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentdelta = delta

func _unhandled_input(event):
	if event is InputEventKey:
		InputController.Check(event)

func _physics_process(delta):
	PlayerController.OnPhysics(delta)
