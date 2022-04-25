extends Area2D

var playerInArea

func _ready():
	playerInArea = false

#signals when collision body enters/exits the area
#collision mask is set to only detect the player
func _on_AttackArea_body_entered(_body):
	playerInArea = true
func _on_AttackArea_body_exited(_body):
	playerInArea = false
