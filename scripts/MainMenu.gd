extends VBoxContainer

func _ready():
	$MenuOptions/SelectLevelButton.grab_focus()

func _on_SelectLevelButton_pressed():
	get_tree().change_scene("res://scenes/Level.tscn")


func _on_SettingsButton_pressed():
	pass # Replace with function body.


func _on_QuitButton_pressed():
	get_tree().quit()
