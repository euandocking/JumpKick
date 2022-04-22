extends Node

var enemies
var enemiesRemaining

export(NodePath) var PlayerPath
var Player

signal enemiesDefeated

func _ready():
	Player = get_node(PlayerPath)
	enemies = get_children()
	for enemy in enemies:
		enemy.Player = Player
	enemiesRemaining = enemies.size()

func _on_Enemy_defeated():
	enemiesRemaining -= 1
	if enemiesRemaining == 0:
		emit_signal("enemiesDefeated")
