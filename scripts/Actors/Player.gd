extends Node2D

#variables
var accelDir
var faceDir
var velocity
var kickSpeed
var touchingLeftWall
var touchingRightWall
var kickablesInArea
var kickablesInSight
var enemiesTouching
var state
var invincible

#states
enum States { ALIVE, DEAD }

#components
onready var PlayerSprite = get_node("PlayerSprite")
onready var PlayerBody = get_node("PlayerBody")
onready var KickAudio = get_node("KickAudio")
onready var HitLabels = get_node("HitLabels")

#hit label reference
onready var HitLabel = preload("res://scenes/HitLabel.tscn")

#signal
signal died

#on start
func _ready():
	#don't accelerate
	accelDir = 0
	#face right
	faceDir = 1
	#set velocity to 0
	velocity = Vector2.ZERO
	
	#initialise variables
	kickSpeed = 1800
	touchingLeftWall = false
	touchingRightWall = false
	kickablesInArea = []
	kickablesInSight = []
	enemiesTouching = []
	state = States.ALIVE
	invincible = false

#update
func _process(_delta):
	#set position to physics body position
	set_position(position + PlayerBody.get_position())
	PlayerBody.set_position(Vector2.ZERO)
	
	#state check
	match state:
		States.ALIVE:
			alive()
		States.DEAD:
			#no functionality but state machine used for potential future extension
			pass

#physics update
func _physics_process(_delta):
	#state check
	match state:
		#when alive
		States.ALIVE:
			#if touching enemies
			if !enemiesTouching.empty():
				#if on floor
				if PlayerBody.is_on_floor():
					#if not invincible
					if !invincible:
						#game over
						die()
	#store velocity from physics body
	velocity = PlayerBody.velocity

#alive state
func alive():
	#determine accel direction based on player input
	#always favours the last key pressed
	if accelDir == 1:
		if Input.is_action_just_pressed("left"):
			accelDir = -1
		elif !Input.is_action_pressed("right"):
			if Input.is_action_pressed("left"):
				accelDir = -1
			else:
				accelDir = 0
	elif accelDir == -1:
		if Input.is_action_just_pressed("right"):
			accelDir = 1
		elif !Input.is_action_pressed("left"):
			if Input.is_action_pressed("right"):
				accelDir = 1
			else:
				accelDir = 0
	else:
		if Input.is_action_pressed("right"):
			accelDir = 1
		elif Input.is_action_pressed("left"):
			accelDir = -1
	
	#passes acceleration direction to player
	PlayerBody.accelDir = accelDir
	
	#set face direction
	if accelDir != 0:
		faceDir = accelDir
	
	#determine kickables in sight
	checkKickables()
	
	#if jump key pressed
	if Input.is_action_just_pressed("jump"):
		#if on floor
		if PlayerBody.is_on_floor():
			#jump
			PlayerBody.jump()
		else:
			#else if there's something to kick
			if !kickablesInSight.empty():
				var averageKickablePos = Vector2.ZERO
				#for each thing to be kicked
				for kickable in kickablesInSight:
					#update the average position of the kickables
					averageKickablePos += kickable.get_global_position()
					#calculate the velocity based on the position difference
					var kickVel = (kickable.get_global_position() - global_position).normalized() * kickSpeed
					#kick the kickable
					kickable.kicked(kickVel)
					#create a hit label
					var tempHitLabel = HitLabel.instance()
					#rotate the label based on the applied velocity
					tempHitLabel.set_rotation(-kickVel.angle_to(Vector2(0,1)))
					#place the label between the player and the kickable
					tempHitLabel.set_global_position(kickable.get_global_position().linear_interpolate(global_position, 0.8))
					#add the label to the scene
					HitLabels.add_child(tempHitLabel)
				#determine the average position of everything that was kicked
				averageKickablePos /= kickablesInSight.size()
				#apply the average kick velocity to the player in the opposite direction
				PlayerBody.kick((global_position - averageKickablePos).normalized() * kickSpeed)
				#play the kick sound
				KickAudio.play()
			#if touching walls jump off them
			#overwrites kick velocity so player has predictable movement
			#while still kicking objects
			if touchingLeftWall:
				PlayerBody.wallJump(1, kickSpeed)
			elif touchingRightWall:
				PlayerBody.wallJump(-1, kickSpeed)
	
	#if drop key pressed
	if Input.is_action_pressed("drop"):
		#turn off one way platform collision
		PlayerBody.set_collision_mask_bit(3, false)
	else:
		#turn on one way platform collision
		PlayerBody.set_collision_mask_bit(3, true)
	
	#animate sprite to face last accelerating direction
	if faceDir == 1:
		PlayerSprite.set_flip_h(false)
	else:
		PlayerSprite.set_flip_h(true)

#switches to dead state
func die():
	#switch state
	state = States.DEAD
	#stop accelerating
	accelDir = 0
	PlayerBody.accelDir = 0
	#emit died signal
	emit_signal("died")

#checks which objects are within sight to kick
#prevents object being kickable through walls
func checkKickables():
	#reset objects to kick
	kickablesInSight = []
	#world space for raycast
	var space_state = get_world_2d().direct_space_state
	#for each object within kickable area
	for kickable in kickablesInArea:
		#set highlight to false
		kickable.showKickableHighlight(false)
		#raycast from player to object (only detects solid wall collisions)
		var result = space_state.intersect_ray(global_position, kickable.get_global_position(), [], 2)
		#if no collisions
		if !result.has("collider"):
			#highlight as kickable
			kickable.showKickableHighlight(true)
			#add to kickables in sight
			kickablesInSight.append(kickable)

#keep track of being next to walls
func _on_RightArea_body_entered(_body):
	touchingRightWall = true
func _on_RightArea_body_exited(_body):
	touchingRightWall = false
func _on_LeftArea_body_entered(_body):
	touchingLeftWall = true
func _on_LeftArea_body_exited(_body):
	touchingLeftWall = false

#keep track of potential kickable objects nearby
func _on_KickArea_area_entered(area):
	kickablesInArea.append(area.get_parent())
func _on_KickArea_area_exited(area):
	kickablesInArea.erase(area.get_parent())
	#hides the higlight when no longer in range of kick
	area.get_parent().showKickableHighlight(false)

#keeps track of enemies touching
func _on_HitArea_body_entered(body):
	enemiesTouching.append(body)
func _on_HitArea_body_exited(body):
	enemiesTouching.erase(body)
