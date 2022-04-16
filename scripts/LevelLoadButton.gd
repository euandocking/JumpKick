extends "MenuButton.gd"

export(String) var levelPath

func _on_MenuButton_pressed():
	get_tree().change_scene(levelPath)
