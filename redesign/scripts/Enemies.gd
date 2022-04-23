extends Node

var enemies

export(NodePath) var PlayerPath
var Player

signal enemyDefeated

func _ready():
	Player = get_node(PlayerPath)
	enemies = get_children()
	for enemy in enemies:
		enemy.Player = Player

func _on_Enemy_defeated():
	emit_signal("enemyDefeated")
