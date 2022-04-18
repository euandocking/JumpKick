extends CanvasLayer

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		if get_node("MainMenu").visible:
			get_node("MainMenu").hide()
			get_tree().paused = false
		elif get_node("LevelSelectMenu").visible:
			get_node("LevelSelectMenu").hide()
			get_node("MainMenu").popup()
		else:
			get_tree().paused = true
			get_node("MainMenu").popup()
