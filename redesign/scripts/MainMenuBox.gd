extends VBoxContainer

signal resumePressed
signal restartPressed
signal quitPressed

func _on_ResumeButton_pressed():
	emit_signal("resumePressed")
func _on_RestartButton_pressed():
	emit_signal("restartPressed")
func _on_QuitButton_pressed():
	emit_signal("quitPressed")



