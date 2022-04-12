extends "Actor.gd"

#variables
var jumpGrav = 40
var upGrav = 60
var downGrav = 90

var jumpForce = 1000
var kickForce = 1200
var jumpDelay = 0.05
onready var jumpTimer = get_node("JumpTimer")

var jumpAvailable = false
var coyoteDelay = 0.0165
onready var coyoteTimer = get_node("CoyoteTimer")

var newVel = Vector2.ZERO

var jumpPressed = false
var jumpHeld = false
var drop = false

var kicked = false
var jumped = true
var missKicked = false

var touchingLeftWall = false
var touchingRightWall = false

var kickables = []
var enemiesTouching = []

onready var PlayerSprite = get_node("PlayerSprite")
onready var KickArea = get_node("KickArea")
onready var KickAudio = get_node("KickAudio")

var playerTexture = preload("res://sprites/player.png")
var playerKickReadyTexture = preload("res://sprites/player_kick_ready.png")

var state = ALIVE
var dead = false

enum {
	ALIVE,
	DEAD
}

func is_dead():
	return dead

func player_inputs():
	if Input.is_action_just_pressed("left"):
		accelDir = -1
	if Input.is_action_just_pressed("right"):
		accelDir = 1
	if Input.is_action_just_released("left"):
		if Input.is_action_pressed("right"):
			accelDir = 1
		else:
			accelDir = 0
	if Input.is_action_just_released("right"):
		if Input.is_action_pressed("left"):
			accelDir = -1
		else:
			accelDir = 0
	if accelDir != 0:
		faceDir = accelDir
	
	if Input.is_action_just_pressed("jump"):
		jumpPressed = true
	else:
		jumpPressed = false
	if Input.is_action_pressed("jump"):
		jumpHeld = true
	else:
		jumpHeld = false
	
	if Input.is_action_just_pressed("drop"):
		drop = true

func animation():
	if !dead:
		if kickables.empty():
			PlayerSprite.set_texture(playerTexture)
		else:
			PlayerSprite.set_texture(playerKickReadyTexture)
		if faceDir == 1:
			PlayerSprite.set_flip_h(false)
		elif faceDir == -1:
			PlayerSprite.set_flip_h(true)
	else:
		PlayerSprite.set_texture(playerTexture)

func accelerate():
	if !dead:
		var newVel = velocity
		
		#acceleration
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

func jumpKick():
	jumpTimer.stop()
	if jumpAvailable:
		jumpAvailable = false
		velocity.y = -jumpForce
	else:
		kicked = true
		jumpAvailable = false
		if !kickables.empty():
			KickAudio.play()
			velocity = (global_position - kickables[0].get_global_position()).normalized() * kickForce
			for kickable in kickables:
				kickable.kicked(-velocity)
		elif touchingLeftWall:
			velocity = Vector2(1, -1).normalized()*kickForce
		elif touchingRightWall:
			velocity = Vector2(-1, -1).normalized()*kickForce
		else:
			jumpTimer.start(jumpTimer.get_time_left())

func alive():
	#check if dead
	if !enemiesTouching.empty():
		if is_on_floor():
			print("lose")
			dead = true
			state = DEAD
	
	#change kick area to direction player is facing
	if faceDir == 1:
		KickArea.set_position(Vector2(8, 32))
	elif faceDir == -1:
		KickArea.set_position(Vector2(-8, 32))
	
	#coyote time reset
	if is_on_floor():
		jumpAvailable = true
	
	#one way collision check
	set_collision_mask_bit(3, true)
	if drop:
		set_collision_mask_bit(3, false)
		drop = false
		jumpAvailable = false
	
	#kick/miss reset
	if is_on_floor() or is_on_wall():
		kicked = false
		missKicked = false
	
	#grav assignment for smoother jump and wall slide
	if velocity.y < 0:
		if jumpHeld:
			grav = jumpGrav
		else:
			grav = upGrav
	else:
		if is_on_wall():
			grav = 20
		else:
			grav = downGrav
	
	#jump/kick
	if jumpPressed:
		if jumpTimer.is_stopped():
			if !missKicked:
				jumpTimer.start(jumpDelay)
	
	if !jumpTimer.is_stopped():
		jumpKick()
	
	if jumpAvailable:
		if !is_on_floor():
			coyoteTimer.start(coyoteDelay)

func _ready():
	accel = 200
	maxAccelSpeed = 600
	decel = 50

func _process(_delta):
	player_inputs()
	animation()

func _physics_process(_delta):
	match state:
		ALIVE:
			alive()
		DEAD:
			if jumpPressed:
				get_tree().reload_current_scene()
	
	move()


#kickable signals
func _on_KickArea_body_entered(body):
	kickables.append(body)
func _on_KickArea_body_exited(body):
	kickables.erase(body)

#enemy signals
func _on_HurtArea_body_entered(body):
	enemiesTouching.append(body)
func _on_HurtArea_body_exited(body):
	enemiesTouching.erase(body)

#wall checks
func _on_RightCheckArea_body_entered(body):
	touchingRightWall = true
func _on_RightCheckArea_body_exited(body):
	touchingRightWall = false
func _on_LeftCheckArea_body_entered(body):
	touchingLeftWall = true
func _on_LeftCheckArea_body_exited(body):
	touchingLeftWall = false

#jump delay timeout
func _on_JumpTimer_timeout():
	missKicked = true

#coyote timeout
func _on_CoyoteTimer_timeout():
	jumpAvailable = false
