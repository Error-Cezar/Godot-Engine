extends Node

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var MoveX = 0
var MoveY = 0

var XSpeed = 2
var YSpeed = 2

var CurrentX = XSpeed * 100
var CurrentY = YSpeed * -100

var Players = []

func Register(Character):
    Players.append(Character)

func OnPhysics(delta):
    for v in Players:
        var Player: CharacterBody2D = v
        Player.velocity.y += gravity * delta

        if MoveY == 1 and Player.is_on_floor():
            Player.velocity.y = CurrentY

        if MoveX != 0:
            Player.velocity.x = MoveX * CurrentX

        Player.move_and_slide()