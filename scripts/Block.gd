extends "Actor.gd"

func _ready():
	decel = 25
	grav = 50

func kicked(vel):
	velocity = vel

func _physics_process(_delta):
	move()
