extends "MenuButton.gd"

export(String) var levelPath
export(String) var levelName
var bestTime = -1

func loadBestTime():
	var save_game = File.new()
	if save_game.file_exists("user:// " + levelName + ".save"):
		save_game.open("user:// " + levelName + ".save", File.READ)
		bestTime = save_game.get_float()
		save_game.close()
	
	var text = "Best Time: "
	if bestTime > 0:
		text += String(stepify(bestTime, 0.01))
	else:
		text += "-"
	
	get_node("BestTimeLabel").set_text(text)

func _ready():
	loadBestTime()

func _on_MenuButton_pressed():
	get_tree().change_scene(levelPath)
	get_tree().paused = false
