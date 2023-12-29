extends Node

var BlitData = { }

func Asset(Data):
	var module = {}
	module.write = func(text: String):
		Data["Write"] = true

		var curcmd = {"command": null, "argument": null}

		var ignore = false
		var current = 0
		var tlen = text.length()

		while current < tlen:
			if not Data["Write"]: break
			if Data["Pause"]: return
			var i: String = text[current]

			if i == "$" and text[current + 1] == "[":
				ignore = true
				var cool  = current + 1
				var addto = 0
				var ended = false
				var savedcmd = []
				var savedarg = []
				while not ended:
					cool += 1
					if cool >= text.length(): 
						break;
					if text[cool] == ":":
						cool += 1
						addto = 1
					if text[cool] == "]":
						break

					if addto == 0:
						savedcmd.append(text[cool])
					else:
						savedarg.append(text[cool])
				if cool < text.length() + 1:
					current = cool + 1
				var cmd = "".join(savedcmd)
				var arg = "".join(savedarg)
				print(cmd, " => ", arg)
				curcmd["command"]  = cmd
				curcmd["argument"] = arg

			match curcmd["command"]:
				"color":
					Data["Color"] = curcmd["argument"]
				"speed":
					Data["Speed"] = int(curcmd["argument"])
				"pause":
					print("pause is indev")
				_:
					pass
					# print("no modes")

			if ignore:
				print("ignored => ", i)
				ignore = false
				continue
			
			var code = i.unicode_at(0)
			var el = Sprite2D.new();
			add_child(el);
			el.reparent(Data["Element"]);
			el.position = Data["Pos"].position
			el.scale = Vector2(.3, .3)

			Data["Pos"].position.x = Data["Pos"].position.x + 10
			
			if code != 32 and code != 10:
				el.texture = load("res://Resources/Fonts/comicsans/" + str(code) + ".png" )
				var Under = Data["Color"]
				if Under == "RND":
					# var bro = Thread.new()
					# bro.start(RndLoop.bind(el))
					
					Under = Color(randf(), randf(), randf())
				el.modulate = Under
			if code == 10:
				Data["Pos"].position.x = Data["Default"].x
				Data["Pos"].position.y = Data["Pos"].position.y + 20

			curcmd["command"]  = null
			curcmd["argument"] = null

			current += 1

			await Frameworks.wait(Data["Speed"])

	return module

func init(Name: String, Blitter: Sprite2D):
	if Name in BlitData: 
		return BlitData[name]
	var Data = { }
	Data["Element"] = Blitter
	Data["Pos"]     = Blitter.get_node("Pos")
	Data["Default"] = Data["Pos"].position
	Data["Color"]   = "BLACK"
	Data["Pause"]   = false
	Data["Write"]   = false
	Data["Speed"]   = 0.1
	Blitter.set_meta("Default", Blitter.position)

	Data = Asset(Data)

	BlitData[name] = Data

	return Data
