extends "Movement.gd"

#on start
func _ready():
	#not acclerating
	accelDir = 0
	
	#set velocity to 0
	velocity = Vector2.ZERO
	
	#set basic movement variables
	grav = 100
	groundDecel = 100
	airDecel = 25
	accel = 200

#apply the movement
func _physics_process(_delta):
	move()
