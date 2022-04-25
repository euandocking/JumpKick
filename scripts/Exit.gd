extends Node2D

#signal to keep track of player entering and leaving the exit area
signal playerEnteredExit
signal playerLeftExit

#keep track of if player is in the area or not
func _on_ExitArea_body_entered(_body):
	emit_signal("playerEnteredExit")
func _on_ExitArea_body_exited(_body):
	emit_signal("playerLeftExit")
