extends Node

var currentdelta = 0

var InputController  = null
var PlayerController = null
var TextBlitter      = null

func InitializeModules():
	InputController  = Frameworks.LoadModule("InputController")
	PlayerController = Frameworks.LoadModule("PlayerController")
	TextBlitter      = Frameworks.LoadModule("TextBlitter")

# Called when the node enters the scene tree for the first time.
func _ready():
	Frameworks.Initialize()
	InitializeModules()
	# ---


func _process(delta):
	currentdelta = delta

func _unhandled_input(event):
	if event is InputEventKey:
		InputController.Check(event)

func _physics_process(delta):
	PlayerController.OnPhysics(delta)
