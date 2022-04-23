extends Node

onready var LevelCamera = get_node("LevelCamera")
onready var Player = get_node("Player")

signal playerInExit
signal playerLeftExit
signal gameOver
signal enemyDefeated

func _process(_delta):
	LevelCamera.set_position(LevelCamera.get_position().linear_interpolate(Player.get_position()+Player.velocity*0.1, 0.1))

func _on_Exit_playerEnteredExit():
	emit_signal("playerInExit")
func _on_Exit_playerLeftExit():
	emit_signal("playerLeftExit")

func _on_Player_died():
	emit_signal("gameOver")

func _on_Enemies_enemyDefeated():
	emit_signal("enemyDefeated") 
