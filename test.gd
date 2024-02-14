extends Node

var Box = null

func BoxElement(El, off):
	off = off.rotated(Box["D"].rotation)
	El.rotation = Box["D"].rotation
	El.global_position = Box["D"].global_position + off

func updatebox():
	var hitbox = Box.get_node("StaticBody2D")
	# var BR = Box.get_node("BR")
	# var BL = Box.get_node("BL")
	# var TR = Box.get_node("TR")
	# var TL = Box.get_node("TL")

	hitbox.get_node("Left").global_position = Vector2(Box.global_position.x, Box.global_position.y + Box.size.y / 2 )
	hitbox.get_node("Left").shape.size = Vector2(5, Box.size.y)

	hitbox.get_node("Right").global_position = Vector2(Box.global_position.x + Box.size.x, Box.global_position.y + Box.size.y / 2 )
	hitbox.get_node("Right").shape.size = Vector2(5, Box.size.y)

	hitbox.get_node("Up").global_position = Vector2(Box.global_position.x + Box.size.x / 2, Box.global_position.y)
	hitbox.get_node("Up").shape.size = Vector2(5, Box.size.y)

	hitbox.get_node("Down").global_position = Vector2(Box.global_position.x + Box.size.x / 2, Box.global_position.y + Box.size.y )
	hitbox.get_node("Down").shape.size = Vector2(5, Box.size.y)


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
	Box = get_node("NinePatchRect")
	
	print("KILL YOURSELF !!!!")

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

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	updatebox()
	pass
