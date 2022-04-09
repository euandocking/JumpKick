extends KinematicBody2D

var faceDir = 1
var accelDir = 0
var accel = 0
var maxAccelSpeed = 0
var decel = 25
var grav = 50
var velocity = Vector2.ZERO

signal accelDirChanged

func set_velocity(vel):
	velocity = vel

func accelerate():
	#acceleration
	if accelDir == 1:
		if velocity.x < maxAccelSpeed:
			velocity.x += accel
			if velocity.x > maxAccelSpeed:
				velocity.x = maxAccelSpeed
	elif accelDir == -1:
		if velocity.x > -maxAccelSpeed:
			velocity.x -= accel
			if velocity.x < -maxAccelSpeed:
				velocity.x = -maxAccelSpeed

func move():
	#deceleration
	if abs(velocity.x) > decel:
		velocity.x -= sign(velocity.x) * decel
	else:
		velocity.x = 0
	
	accelerate()
	
	#gravity
	velocity.y += grav
	
	#apply velocity
	velocity = move_and_slide(velocity, Vector2.UP)
