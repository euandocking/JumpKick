extends Node


onready var enemies = get_children()
onready var enemiesLeft = enemies.size()
signal enemiesDefeated


func _on_Enemy_died():
	print("enemy died")
	enemiesLeft -= 1
	if enemiesLeft == 0:
		emit_signal("enemiesDefeated")
