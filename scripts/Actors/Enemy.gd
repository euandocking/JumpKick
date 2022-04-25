extends Node2D

#variables
#state
var state
#enemy specific movement
var patrolAccel
var attackAccel
var patrolMaxSpeed
var	attackMaxSpeed
#patrol route
var PatrolPoints
var patrolIndex
var lastPoint
var nextPoint
#node reference
var AttackArea
var Player
#horizontal facing
var faceDir
#player in detection area
var playerInDetectArea

#enemy states
enum States { PATROL, ATTACK, STUNNED, DEAD }

#required node paths
export(NodePath) var AttackAreaPath
export(NodePath) var PatrolRoutePath

#component references
onready var EnemyBody = get_node("EnemyBody")
onready var EnemySprite = get_node("EnemySprite")
onready var Kickable = get_node("Kickable")
onready var StunnedTimer = get_node("StunnedTimer")

#signal for when defeated
signal defeated

#start function
func _ready():
	#if patrol route was given, get a reference to its points
	if PatrolRoutePath:
		PatrolPoints = get_node(PatrolRoutePath).get_children()
		#if points existed
		if PatrolPoints:
			#set the index to the first point
			patrolIndex = 0
			#set the reference to the last point
			lastPoint = PatrolPoints[PatrolPoints.size()-1]
			#set the reference to the target point
			nextPoint = PatrolPoints[patrolIndex]
	
	#if attack area was given, get a reference to it
	if AttackAreaPath:
		AttackArea = get_node(AttackAreaPath)
	
	#set the state to patrol
	state = States.PATROL
	
	#set the speed variables
	patrolAccel = 150
	attackAccel = 200
	patrolMaxSpeed = 400
	attackMaxSpeed = 800
	EnemyBody.accel = patrolAccel
	EnemyBody.maxAccelSpeed = patrolMaxSpeed
	
	#face the right
	faceDir = 1
	#start assuming player is not within detection range
	playerInDetectArea = false

func _process(_delta):
	#state check
	#essentially just prevents animation if the enemy is dead
	#kept as a state machine for possible future extension
	match state:
		States.ATTACK:
			animate()
		States.PATROL:
			animate()
	#set face direction
	if EnemyBody.accelDir != 0:
		faceDir = EnemyBody.accelDir

func _physics_process(_delta):
	#updates position based on kinematic body
	set_position(position + EnemyBody.get_position())
	EnemyBody.set_position(Vector2.ZERO)
	
	#pass velocity down to kickable component
	Kickable.velocity = EnemyBody.velocity
	
	#state check with appropraite methods
	match state:
		States.ATTACK:
			attack()
		States.PATROL:
			patrol()

#flips sprite to look in direction enemy is moving
func animate():
	if faceDir == 1:
		EnemySprite.set_flip_h(false)
	else:
		EnemySprite.set_flip_h(true)

#patrol state function
func patrol():
	#follow patrol route
	#if patrol route exists
	if PatrolPoints:
		#get the direction to the target point from the previous point
		var pathDir = sign(nextPoint.position.x - lastPoint.position.x)
		#get the direction to the target point from the enemy
		var newDir = sign(nextPoint.position.x - position.x)
		#if both directions don't match (i.e. player has gone past the point)
		if newDir != pathDir:
			#set the target point to the following point
			#and update the previous point
			patrolIndex = wrapi(patrolIndex + 1, 0, PatrolPoints.size())
			lastPoint = PatrolPoints[wrapi(patrolIndex - 1, 0, PatrolPoints.size())]
			nextPoint = PatrolPoints[patrolIndex]
			#set the new direction appropriately (necessary so the enemy doesn't waste
			#a frame moving in the wrong direction)
			newDir = sign(nextPoint.position.x - position.x)
		#pass movement direction to the physics body
		EnemyBody.accelDir = newDir
	
	#detection check
	#if player exists
	if Player:
		#if the player isn't dead
		if Player.state != Player.States.DEAD:
			#if player is in the enemy's detection area
			if playerInDetectArea:
				#if the player is on the side that the enemy is facing
				if sign(Player.get_global_position().x - global_position.x) == faceDir:
					#raycast to player from enemy
					var space_state = get_world_2d().direct_space_state
					var result = space_state.intersect_ray(global_position, Player.get_global_position(), [EnemyBody, Player.PlayerBody])
					#if no collision inbetween player and enemy
					if result.empty():
						#switch to attack state
						attackState()

#attack state function
func attack():
	#if attack area exists
	if AttackArea:
		#set the acceleration direction to 0
		EnemyBody.accelDir = 0
		#if player is in attack area
		if AttackArea.playerInArea:
			#get the distance to the player from the enemy
			var toPlayer = Player.global_position - global_position
			#if outside touching range of player
			if abs(toPlayer.x) > 16:
				#move towards the player
				EnemyBody.accelDir = sign(toPlayer.x)
	
	#detection check
	if Player:
		#if player is not in detection area or player is dead
		if !playerInDetectArea or Player.state == Player.States.DEAD:
			#switch to patrol state
			state = States.PATROL
			#switch to patrol animation
			EnemySprite.animation = "idle"
			#switch the attack collision off
			EnemyBody.set_collision_layer_bit(4, false)
			#switch to patrol movement speeds
			EnemyBody.maxAccelSpeed = patrolMaxSpeed
			EnemyBody.accel = patrolAccel

#returns the physics body
func getBody():
	return EnemyBody

#attack state switch
func attackState():
	#switch to the attack state
	state = States.ATTACK
	#activate the enemy "hit" collision
	EnemyBody.set_collision_layer_bit(4, true)
	#update movement speeds to attack speeds
	EnemyBody.maxAccelSpeed = attackMaxSpeed
	EnemyBody.accel = attackAccel
	#switch to attack animation
	EnemySprite.animation = "attack"

#stuns the enemy
func stunned():
	#if not dead
	if state != States.DEAD:
		#switch to stunned state
		state = States.STUNNED
		#display behind other enemies
		EnemySprite.z_index = -1
		#start the stunned timer
		StunnedTimer.start(1)
		#stop accelerating
		EnemyBody.accelDir = 0
		#switch off the attack collision
		EnemyBody.set_collision_layer_bit(4, false)
		#switch to the stunned animation
		EnemySprite.animation = "stunned"

#kicked signal
func _on_Kickable_kicked(kickVel):
	#if not dead
	if state != States.DEAD:
		#emit defeated signal
		emit_signal("defeated")
		#stop accelerating
		EnemyBody.accelDir = 0
		#switch to dead state
		state = States.DEAD
		#display behind all other enemies
		EnemySprite.z_index = -2
		#switch off attack collision
		EnemyBody.set_collision_layer_bit(4, false)
		#switch to dead animation
		EnemySprite.animation = "dead"
	#apply kick velocity to the body
	getBody().velocity = kickVel

#keep track of player entering and leaving the detection area
func _on_DetectionArea_body_entered(_body):
	playerInDetectArea = true
func _on_DetectionArea_body_exited(_body):
	playerInDetectArea = false

#when stun timer runs out
func _on_StunnedTimer_timeout():
	#if not dead
	if state != States.DEAD:
		#return to the attack state
		EnemySprite.z_index = 0
		attackState()

