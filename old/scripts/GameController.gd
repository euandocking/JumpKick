extends Node

var time = 0
var bestTime = -1
var levelName = "res://scenes/levels/StreetsLevel.tscn"

func loadBestTime():
	var save_game = File.new()
	if save_game.file_exists("user:// " + levelName + ".save"):
		save_game.open("user:// " + levelName + ".save", File.READ)
		bestTime = save_game.get_float()
		get_node("GUI/BestTime").set_text("Best Time: " + String(stepify(bestTime, 0.01)))
		save_game.close()

func win():
	get_node("GUI/LevelCompletePopup").popup()
	
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

func gameOver():
	get_tree().paused = true
	get_node("GUI/GameOverPopup").popup()

func _ready():
	#load start level from file
	var startLevel = "res://scenes/levels/StreetsLevel.tscn"
	var save_game = File.new()
	if save_game.file_exists("user://startLevel.save"):
		save_game.open("user://startLevel.save", File.READ)
		startLevel = save_game.get_line()
		save_game.close()
	print(startLevel)
	var level = load("res://scenes/levels/StreetsLevel.tscn")
	var levelInst = level.instance()
	get_node("CurrentLevel").add_child(levelInst)
	var levelName = startLevel
	
	#load best time
	loadBestTime()
	
func _process(delta):
	if !get_tree().paused:
		time += delta
		get_node("GUI/PlayTime").text = "Time: " + String(stepify(time, 0.01))
