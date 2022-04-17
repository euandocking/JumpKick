extends Node2D

var bestTime = -1
export(String) var levelName

func loadBestTime():
	var save_game = File.new()
	print(bestTime)
	if save_game.file_exists("user:// " + levelName + ".save"):
		save_game.open("user:// " + levelName + ".save", File.READ)
		bestTime = save_game.get_float()
		get_node("GUI/BestTime").set_text("Best Time: " + String(stepify(bestTime, 0.01)))
		save_game.close()
	print(bestTime)

func win():
	var time = get_node("GUI/PlayTime").time
	
	if bestTime == -1:
		var save_game = File.new()
		save_game.open("user:// " + levelName + ".save", File.WRITE)
		save_game.store_float(time)
		save_game.close()
	elif time < bestTime:
		var save_game = File.new()
		save_game.open("user:// " + levelName + ".save", File.WRITE)
		save_game.store_float(time)
		save_game.close()
	print("win: " + String(time) +  " seconds")
	get_tree().change_scene("res://scenes/menus/LevelSelectMenu.tscn")

func _ready():
	loadBestTime()
