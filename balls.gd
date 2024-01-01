extends Node

var BoxController  = null

func InitializeModules():
	BoxController = Frameworks.LoadModule("BoxController")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("go")
	Frameworks.Initialize()
	InitializeModules()
	# ---
	var info = {"U" = get_node("U"), "D" = get_node("D"), "L" = get_node("L"), "R" = get_node("R")}
	var pos = {U = info["U"].position.y, D = info["D"].position.y, L = info["L"].position.x, R = info["R"].position.x}
	BoxController.init("Box", info, pos)
	BoxController.int()

func _physics_process(_delta):
	Frameworks.OnProccess()
