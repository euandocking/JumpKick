extends VBoxContainer

#button signals
signal resumePressed
signal restartPressed
signal levelSelectPressed
signal settingsPressed
signal helpPressed
signal creditsPressed
signal quitPressed

#emit button signals on button presses
func _on_ResumeButton_pressed():
	emit_signal("resumePressed")
func _on_RestartButton_pressed():
	emit_signal("restartPressed")
func _on_LevelSelectButton_pressed():
	emit_signal("levelSelectPressed")
func _on_SettingsButton_pressed():
	emit_signal("settingsPressed")
func _on_HelpButton_pressed():
	emit_signal("helpPressed")
func _on_CreditsButton_pressed():
	emit_signal("creditsPressed")
func _on_QuitButton_pressed():
	emit_signal("quitPressed")
