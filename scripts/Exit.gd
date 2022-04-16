extends Area2D

var playerInArea = false
var enemiesDefeated = false

func win():
	print("win")
	get_tree().change_scene("res://scenes/menus/LevelSelectMenu.tscn")

func _on_ExitArea_body_entered(body):
	playerInArea = true
	if enemiesDefeated:
		win()

func _on_ExitArea_body_exited(body):
	playerInArea = false

func _on_Enemies_enemiesDefeated():
	enemiesDefeated = true
	if playerInArea:
		win()
