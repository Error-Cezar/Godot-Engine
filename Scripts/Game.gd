extends Node

var currentdelta = 0

var InputController  = null
var PlayerController = null
var TextBlitter      = null

var offX = 0
var offY = 0

func InitializeModules():
	InputController  = Frameworks.LoadModule("InputController")
	PlayerController = Frameworks.LoadModule("PlayerController")
	TextBlitter      = Frameworks.LoadModule("TextBlitter")

# Called when the node enters the scene tree for the first time.
func _ready():
	Frameworks.Initialize()
	InitializeModules()
	# ---
	PlayerController.Register(get_node("Player"))

	print("------------------")
	print("GAME SERVER INIT")
	
	InputController.OnPress(KEY_Z, func():
		print("Z ON")
		PlayerController.MoveY = 1
	)
	InputController.OnRelease(KEY_Z, func():
		print("Z OFF")
		PlayerController.MoveY = 0
	)
	
	InputController.OnPress(KEY_S, func():
		print("S ON")
		PlayerController.MoveY = -1
	)
	InputController.OnRelease(KEY_S, func():
		print("S OFF")
		if PlayerController.MoveY != -1:
			return 
		PlayerController.MoveY = 0
	)
	
	InputController.OnPress(KEY_D, func():
		print("D ON")
		PlayerController.MoveX = 1
	)
	
	InputController.OnRelease(KEY_D, func():
		if PlayerController.MoveX != 1:
			return 
		print("D OFF", PlayerController.MoveX)
		PlayerController.MoveX = 0
	)
	
	InputController.OnPress(KEY_Q, func():
		PlayerController.MoveX = -1
	)
	
	InputController.OnPress(KEY_F, func():
		PlayerController.Players[0]["Mode"] = 2
	)
	
	InputController.OnRelease(KEY_Q, func():
		if PlayerController.MoveX != -1:
			return 
		PlayerController.MoveX = 0
	)
	
	var ok = TextBlitter.init("balls", get_node("TextBox"))
	print(ok["write"])
	ok["write"].call("im making progress\n$[color:RND]$[speed:0.9]this is cool right?")


func _process(delta):
	currentdelta = delta

func _unhandled_input(event):
	if event is InputEventKey:
		InputController.Check(event)

func _physics_process(delta):
	PlayerController.OnPhysics(delta)
