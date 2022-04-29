extends KinematicBody2D

#basic movement variables
var accelDir
var velocity
var grav
var accel
var groundDecel
var airDecel
var maxAccelSpeed
var maxFallSpeed

#on start
func _ready():
	#don't accelerate
	accelDir = 0
	
	#set velocity to 0
	velocity = Vector2.ZERO
	
	#initialise movement variables
	grav = 100
	accel = 200
	groundDecel = 100
	airDecel = 25
	maxAccelSpeed = 800
	maxFallSpeed = 2000

#basic move function
func move():
	#deceleration
	#set relevant deceleration based on if on ground or in air
	var decel
	if is_on_floor():
		decel = groundDecel
	else:
		decel = airDecel
	
	#if further deceleration doesn't move object in opposite direction
	if abs(velocity.x) > decel:
		#apply deceleration
		velocity.x -= sign(velocity.x) * decel
	#else stop object
	else:
		velocity.x = 0
	
	#apply acceleration
	accelerate()
	
	#apply gravity
	velocity.y += grav
	#apply max fall speed
	if velocity.y > maxFallSpeed:
		velocity.y = maxFallSpeed
	
	#apply velocity
	velocity = move_and_slide(velocity, Vector2.UP)

#accelerate function
func accelerate():
	#if accelerating to the right
	if accelDir == 1:
		#if below max move speed
		if velocity.x < maxAccelSpeed:
			#apply acceleration to right
			velocity.x += accel
			#if now above max speed
			if velocity.x > maxAccelSpeed:
				#set speed to max speed
				velocity.x = maxAccelSpeed
	elif accelDir == -1:
		#if accelerating to the right
		if velocity.x > -maxAccelSpeed:
			#apply acceleration to left
			velocity.x -= accel
			#if below max move speed
			if velocity.x < -maxAccelSpeed:
				#apply acceleration
				velocity.x = -maxAccelSpeed

