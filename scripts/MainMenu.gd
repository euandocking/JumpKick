extends Popup

func _ready():
	$Menu/MenuOptions.get_children()[0].grab_focus()

func _on_SelectLevelButton_pressed():
	get_parent().get_node("LevelSelectMenu").popup()
	hide()


func _on_SettingsButton_pressed():
	pass # Replace with function body.


func _on_QuitButton_pressed():
	#save current level to file
	var save_game = File.new()
	save_game.open("user://startLevel.save", File.WRITE)
	save_game.store_string(get_parent().get_parent().get_filename())
	save_game.close()
	get_tree().quit()
