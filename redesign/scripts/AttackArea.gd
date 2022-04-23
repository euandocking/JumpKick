extends Area2D

var playerInArea

func _ready():
	playerInArea = false

func _on_AttackArea_body_entered(_body):
	playerInArea = true
func _on_AttackArea_body_exited(_body):
	playerInArea = false
