extends "Movement.gd"

var kicked

var jumpSpeed
var jumpGrav
var fallGrav

func _ready():
	accelDir = 0
	
	kicked = false
	velocity = Vector2.ZERO
	
	jumpSpeed = 1200
	jumpGrav = 50
	fallGrav = 100
	
	accel = 200
	groundDecel = 100
	airDecel = 25
	maxAccelSpeed = 800


func _physics_process(_delta):
	#resets
	if is_on_floor():
		kicked = false
	
	if Input.is_action_pressed("jump") and velocity.y < 0:
		grav = jumpGrav
	else:
		grav = fallGrav
	
	move()

func accelerate():
	var newVel = velocity
	if accelDir == 1:
		if newVel.x < maxAccelSpeed:
			newVel.x += accel
			if newVel.x > maxAccelSpeed:
				newVel.x = maxAccelSpeed
	elif accelDir == -1:
		if newVel.x > -maxAccelSpeed:
			newVel.x -= accel
			if newVel.x < -maxAccelSpeed:
				newVel.x = -maxAccelSpeed
	
	if !kicked:
		velocity = newVel
	else:
		velocity = velocity.linear_interpolate(newVel, 0.5)

func jump():
	velocity.y = -jumpSpeed

func wallJump(dir, kickSpeed):
	kicked = true
	velocity = Vector2(dir, -1).normalized() * kickSpeed

func kick(vel):
	kicked = true
	velocity = vel
	
