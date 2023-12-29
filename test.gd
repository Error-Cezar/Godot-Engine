extends Node

var Box = {}

func BoxElement(El, off):
	off = off.rotated(Box["D"].rotation)
	El.rotation = Box["D"].rotation
	El.global_position = Box["D"].global_position + off

func updatebox():
	BoxElement(Box["L"], Vector2(-Box["D"].texture.get_width() * Box["D"].scale.x /2, 0))

	BoxElement(Box["R"], Vector2(Box["D"].texture.get_width() * Box["D"].scale.x /2, 0))

	Box["U"].scale = Box["D"].scale
	BoxElement(Box["U"], Vector2(Box["L"].texture.get_width() * Box["L"].scale.x /2, -Box["L"].texture.get_height() * Box["L"].scale.y))

	BoxElement(Box["H"], Vector2(Box["L"].texture.get_width() * Box["L"].scale.x /2, -Box["L"].texture.get_height() * Box["L"].scale.y))
	Box["H"].scale = Vector2(Box["D"].scale.x - Box["L"].scale.x / 2, Box["L"].scale.y - Box["D"].scale.y)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	Box["U"] = get_node("U")
	Box["D"] = get_node("D")
	Box["R"] = get_node("R")
	Box["L"] = get_node("L")

	Box["H"] = get_node("H")
	
	print("KILL YOURSELF !!!!")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	updatebox()
	pass
