extends Popup

func _ready():
	$Menu/MenuOptions.get_children()[0].grab_focus()

func _on_SelectLevelButton_pressed():
	get_parent().get_node("LevelSelectMenu").popup()
	hide()


func _on_SettingsButton_pressed():
	pass # Replace with function body.


func _on_QuitButton_pressed():
	get_tree().quit()
