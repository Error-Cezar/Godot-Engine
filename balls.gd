extends Node

var BoxController  = null

func InitializeModules():
	BoxController = Frameworks.LoadModule("BoxController")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("go!!!!!!!!!!!!!!")
	Frameworks.Initialize()
	InitializeModules()
	# ---
	var info = {"U" = get_node("U"), "D" = get_node("D"), "L" = get_node("L"), "R" = get_node("R")}
	var pos = {U = info["U"].position.y, D = info["D"].position.y, L = info["L"].position.x, R = info["R"].position.x}
	var B = BoxController.init("Box", info, pos)
	B["move"].call({"first": 3})
	await Frameworks.wait(1)
	B["DU"] = 10
	await Frameworks.wait(.5)
	B["test"].call()

func _physics_process(_delta):
	Frameworks.OnProccess()
