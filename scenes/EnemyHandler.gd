extends Node


onready var enemies = get_children()
onready var enemiesLeft = enemies.size()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Enemy_died():
	enemiesLeft -= 1
	if enemiesLeft == 0:
		print("win")
		get_tree().reload_current_scene()
