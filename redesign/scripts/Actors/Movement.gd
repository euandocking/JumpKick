extends KinematicBody2D

var accelDir

var velocity

var grav

var accel
var groundDecel
var airDecel
var maxAccelSpeed

func _ready():
	accelDir = 0
	
	velocity = Vector2.ZERO
	
	grav = 100
	
	accel = 200
	groundDecel = 100
	airDecel = 25
	maxAccelSpeed = 800

func move():
	#deceleration
	var decel
	if is_on_floor():
		decel = groundDecel
	else:
		decel = airDecel
	
	if abs(velocity.x) > decel:
		velocity.x -= sign(velocity.x) * decel
	else:
		velocity.x = 0
	
	#apply acceleration
	accelerate()
	
	#apply gravity
	velocity.y += grav
	
	#apply velocity
	velocity = move_and_slide(velocity, Vector2.UP)

func accelerate():
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

