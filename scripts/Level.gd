extends Node2D

var stopped = false
var time = 0
var bestTime = -1
export(String) var levelName

func loadBestTime():
	var save_game = File.new()
	if save_game.file_exists("user:// " + levelName + ".save"):
		save_game.open("user:// " + levelName + ".save", File.READ)
		bestTime = save_game.get_float()
		get_node("GUI/BestTime").set_text("Best Time: " + String(stepify(bestTime, 0.01)))
		save_game.close()

func win():
	stopped = true
	get_node("PlayerBody").state = 1
	get_node("PlayerBody").dead = true
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
	stopped = true
	get_node("GUI/GameOverPopup").popup()

func _ready():
	loadBestTime()

func _process(delta):
	if !stopped:
		time += delta
		get_node("GUI/PlayTime").text = "Time: " + String(stepify(time, 0.01))
