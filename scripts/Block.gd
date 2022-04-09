extends "Actor.gd"

#variables
var enemiesTouching = []

func kicked(vel):
	velocity = vel

func _ready():
	decel = 25
	grav = 50

func _physics_process(_delta):
	if velocity != Vector2.ZERO:
		if !enemiesTouching.empty():
			for enemy in enemiesTouching:
				enemy.kicked(velocity)
	
	move()

#enemy collision check
func _on_HitArea_body_entered(body):
	enemiesTouching.append(body)
func _on_HitArea_body_exited(body):
	enemiesTouching.erase(body)
