extends Node

var playerInExit
var enemiesDefeated

onready var LevelCamera = get_node("LevelCamera")
onready var Player = get_node("Player")

signal levelCompleted
signal gameOver

func _process(_delta):
	LevelCamera.set_position(LevelCamera.get_position().linear_interpolate(Player.get_position()+Player.velocity*0.1, 0.1))

func _on_Enemies_enemiesDefeated():
	if playerInExit:
		emit_signal("levelCompleted")
	enemiesDefeated = true

func _on_Exit_playerEnteredExit():
	if enemiesDefeated:
		emit_signal("levelCompleted")
	playerInExit = true
func _on_Exit_playerLeftExit():
	playerInExit = false

func _on_Player_died():
	emit_signal("gameOver")
