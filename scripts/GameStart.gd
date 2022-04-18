extends Node

func _ready():
	#load start level from file
	var startLevel = "res://scenes/levels/StreetsLevel.tscn"
	var save_game = File.new()
	if save_game.file_exists("user://startLevel.save"):
		save_game.open("user://startLevel.save", File.READ)
		startLevel = save_game.get_line()
		save_game.close()
	get_tree().change_scene(startLevel)
	
