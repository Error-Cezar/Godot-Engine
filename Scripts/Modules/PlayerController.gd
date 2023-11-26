extends Node

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var MoveX = 0
var MoveY = 0

var XSpeed = 2
var YSpeed = 2

var CurrentX = XSpeed * 100
var CurrentY = YSpeed * -100

var JumpMul = 11
var YGo = 0
var JumpLock = false

var Players = []

func Register(Character):
	Players.append({
		"Character": Character,
		"Mode"     : 1
	})

func OnPhysics(delta):
	for v in Players:
		var Player: CharacterBody2D = v["Character"]
		var Mode: int = v["Mode"]
		
		if MoveX != 0:
			Player.velocity.x = CurrentX * MoveX
		else:
			Player.velocity.x = 0
					
		match Mode:
			1:
				if MoveY != 0:
					Player.velocity.y = CurrentY * MoveY
				else:
					Player.velocity.y = 0
				Player.move_and_slide()
			2:
				var OnFloor: bool = Player.is_on_floor()
				Player.velocity.y += gravity * delta
				if MoveY == 1:
					if OnFloor and JumpLock:
						JumpLock = false
						YGo = 0
					if(OnFloor or YGo > CurrentY * JumpMul) and not JumpLock:
						if OnFloor:
							JumpLock = false
							YGo = 0
						YGo -= 100
						Player.velocity.y = CurrentY
					elif Player.velocity.y < 0 and not JumpLock:
						JumpLock = true
						Player.velocity.y -= CurrentY
				if MoveY == 0:
					match OnFloor:
						true:
							if JumpLock:
								JumpLock = false
						false:
							if not JumpLock:
								JumpLock = true
								Player.velocity.y -= CurrentY
							if YGo < 0:
								YGo += 100
				Player.move_and_slide()
