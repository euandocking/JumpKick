extends "Movement.gd"

#variables
var kicked
var jumpSpeed
var jumpGrav
var fallGrav

#on start
func _ready():
	#initialise variables
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
	#reset kicked flag
	if is_on_floor():
		kicked = false
	
	#change gravity based on if key held or falling to provide smoother jump
	if Input.is_action_pressed("jump") and velocity.y < 0:
		grav = jumpGrav
	else:
		grav = fallGrav
	
	#move the body according to velocity
	move()

#accelerate function
func accelerate():
	#gets potential new velocity based on acceleration
	var newVel = velocity
	#if accelerating to the right
	if accelDir == 1:
		#if below max speed
		if newVel.x < maxAccelSpeed:
			#apply right acceleration
			newVel.x += accel
			#if now above max speed
			if newVel.x > maxAccelSpeed:
				#set to max speed
				newVel.x = maxAccelSpeed
	#else if accelerating to the left
	elif accelDir == -1:
		#if below max speed
		if newVel.x > -maxAccelSpeed:
			#apply left acceleration
			newVel.x -= accel
			#if now above max speed
			if newVel.x < -maxAccelSpeed:
				#set to max speed
				newVel.x = -maxAccelSpeed
	
	#if not kicked/wall jumped
	if !kicked:
		#set to expected velocity
		velocity = newVel
	#if have kicked/wall jumped
	else:
		#smooth out velocity
		#takes some control away from player to improve game feel
		velocity = velocity.linear_interpolate(newVel, 0.5)

#makes the player jump
func jump():
	#applies jump speed upwards
	velocity.y = -jumpSpeed

#wall jump
func wallJump(dir, kickSpeed):
	#marks kicked flag
	kicked = true
	#applies kick speed evenly between up and opposite from wall
	velocity = Vector2(dir, -1).normalized() * kickSpeed

#kick function
func kick(vel):
	#set kick flag to true
	kicked = true
	#applies velocity
	velocity = vel
	
