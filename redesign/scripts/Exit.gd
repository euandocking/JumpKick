extends Node2D

signal playerEnteredExit
signal playerLeftExit

func _on_ExitArea_body_entered(_body):
	emit_signal("playerEnteredExit")
func _on_ExitArea_body_exited(_body):
	emit_signal("playerLeftExit")
