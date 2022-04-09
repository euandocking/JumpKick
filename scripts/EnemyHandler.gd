extends Node

export(NodePath) var PlayerPath
onready var enemies = get_children()
var enemiesRemaining
signal enemiesDefeated

func _ready():
	enemiesRemaining = enemies.size()
	
	var Player = get_node(PlayerPath)
	for enemy in enemies:
		enemy.setPlayer(Player)

func _on_Enemy_died():
	enemiesRemaining -= 1
	if enemiesRemaining == 0:
		emit_signal("enemiesDefeated")
