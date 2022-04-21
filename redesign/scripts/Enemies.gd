extends Node

var enemies
var enemiesRemaining

signal enemiesDefeated

func _ready():
	enemies = get_children()
	enemiesRemaining = enemies.size()

func _on_Enemy_defeated():
	enemiesRemaining -= 1
	if enemiesRemaining == 0:
		emit_signal("enemiesDefeated")
