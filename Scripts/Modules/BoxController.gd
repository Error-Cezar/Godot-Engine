extends Node

var BoxAsset = { }

func metadata(Data): 
	var module = {}

	var _BoxElement = func(El, off):
		off = off.rotated(module.Box["D"].rotation)
		El.rotation = module.Box["D"].rotation
		El.global_position = module.Box["D"].global_position + off

	module.CheckStat = {
		L = true,
		R = true,
		D = true,
		U = true
	}

	module.L = Data["L"]
	module.R = Data["R"]
	module.U = Data["U"]
	module.D = Data["D"]

	module.LU = Data["L"]
	module.RU = Data["R"]
	module.UU = Data["U"]
	module.DU = Data["D"]

	module.XWall = ["L", "R"]
	module.YWall = ["D", "U"]

	module.Box      = Data["Box"]
	module.Rotation = Data["Rotation"]
	module.test = func():
		print(module.Box["U"])


	return module

func init(Name: String, Box: Dictionary, Position: Dictionary = {L = 0, R = 0, U = 0, D = 0}):
	if Name in BoxAsset: 
		return BoxAsset[name]
	var Data = { }
	Data["Box"] = Box
	Data["Rotation"] = 0

	Data["L"] = Position["L"]
	Data["R"] = Position["R"]

	Data["D"] = Position["D"]
	Data["U"] = Position["U"]

	Data = metadata(Data)
	BoxAsset[Name] = Data

	return Data

func int():
	Frameworks.proc_check("BOX_CHECKER", func():
		for v in BoxAsset:
			var Data = BoxAsset[v]
			for stat in Data["CheckStat"]:
				var mode = Data["CheckStat"][stat]
				if mode == false: continue;
				var Box = Data["Box"][stat]
				if not Box: continue;

				var Pos = Data[stat]
				var Vec = "Y"
				if stat in Data["XWall"]: Vec = "X";
				if Data[stat + "U"] == Pos: continue;

				var tween = Frameworks.tween()

				Data[stat + "U"] = Pos
				match Vec:
					"X":
						if Box.position.x != Pos:
							tween.tween_property(Box, "position", Vector2(Pos, Box.position.y), 2)
						pass;
					"Y":
						if Box.position.y != Pos:
							tween.tween_property(Box, "position", Vector2(Box.position.x, Pos), 2)
						pass;
					_:
						print("What The Hell Is That Vec ", Vec)

	);
