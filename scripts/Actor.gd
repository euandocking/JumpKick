extends KinematicBody2D

var accelDir = 0
var accel = 0
var maxAccelSpeed = 0
var decel = 25
var grav = 50
var velocity = Vector2.ZERO

signal accelDirChanged

func set_velocity(vel):
	velocity = vel

func move():
	#acceleration
	if accelDir == 1:
		if velocity.x < maxAccelSpeed:
			velocity.x += accel
	elif accelDir == -1:
		if velocity.x > -maxAccelSpeed:
			velocity.x -= accel
	
	#deceleration
	if abs(velocity.x) > decel:
		velocity.x -= sign(velocity.x) * decel
	else:
		velocity.x = 0
	
	#gravity
	velocity.y += grav
	
	#apply velocity
	velocity = move_and_slide(velocity, Vector2.UP)
