extends Node2D

var enemiesDefeated = false
var inExitArea = false

signal gameOver
signal levelComplete

func _on_PlayerBody_gameOver():
	emit_signal("gameOver")

func _on_Enemies_enemiesDefeated():
	enemiesDefeated = true
	if inExitArea:
		emit_signal("levelComplete")

func _on_ExitArea_body_entered(body):
	inExitArea = true
	if enemiesDefeated:
		emit_signal("levelComplete")

func _on_ExitArea_body_exited(body):
	inExitArea = false
