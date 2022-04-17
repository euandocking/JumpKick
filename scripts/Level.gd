extends Node2D

func save(content):
	var file = File.new()
	file.open("user://save_game.dat", File.WRITE)
	file.store_string(content)
	file.close()

func load():
	var file = File.new()
	file.open("user://save_game.dat", File.READ)
	var content = file.get_as_text()
	file.close()
	return content

func win():
	var time = get_node("GUI/PlayTime").time
	print("win: " + String(time) +  " seconds")
	get_tree().change_scene("res://scenes/menus/LevelSelectMenu.tscn")
