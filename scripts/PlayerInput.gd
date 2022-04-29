extends Node

var accelDir

func _ready():
	accelDir = 0

func _process(_delta):
	#determine accel direction based on player input
	#always favours the last key pressed
	#if accelerating to the right
	if accelDir == 1:
		#if left key pressed
		if Input.is_action_just_pressed("left"):
			#switch direction
			accelDir = -1
		#else if right key not held
		elif !Input.is_action_pressed("right"):
			#if left key held
			if Input.is_action_pressed("left"):
				#switch direction
				accelDir = -1
			#else stop accelerating
			else:
				accelDir = 0
	#else if accelerating to the left
	elif accelDir == -1:
		#if right key pressed
		if Input.is_action_just_pressed("right"):
			#switch direction
			accelDir = 1
		#else if left key not held
		elif !Input.is_action_pressed("left"):
			#if right key held
			if Input.is_action_pressed("right"):
				#switch direction
				accelDir = 1
			#else stop
			else:
				accelDir = 0
	#else accelerate in direction of key held
	else:
		if Input.is_action_pressed("right"):
			accelDir = 1
		elif Input.is_action_pressed("left"):
			accelDir = -1
