extends "Movement.gd"

var patrolMaxSpeed
var attackMaxSpeed

func _ready():
	accelDir = 0
	
	velocity = Vector2.ZERO
	
	grav = 100
	
	accel = 200
	groundDecel = 100
	airDecel = 25
	maxAccelSpeed = 400

func _physics_process(_delta):
	move()
