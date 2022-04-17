extends "Actor.gd"

#variables
var jumpGrav = 40
var upGrav = 60
var downGrav = 90

var jumpForce = 1000
var kickForce = 1200
var jumpDelay = 0.025
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
var toKick = []
var enemiesTouching = []

onready var PlayerSprite = get_node("PlayerSprite")
onready var KickArea = get_node("KickArea")
onready var KickAudio = get_node("KickAudio")
onready var hitLabels = get_node("HitLabels")

var hitLabel = load("res://scenes/HitLabel.tscn")

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
	
	if Input.is_action_pressed("drop"):
		drop = true
	else:
		drop = false

func animation():
	if !dead:
		if missKicked:
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
		if !toKick.empty():
			var averageKickablePos = Vector2.ZERO
			for kickable in toKick:
				var tempHitLabel = hitLabel.instance()
				var kickVel = (kickable.get_global_position() - global_position).normalized() * kickForce
				tempHitLabel.set_rotation(-kickVel.angle_to(Vector2(0,1)))
				tempHitLabel.set_global_position(kickable.get_global_position().linear_interpolate(global_position, 0.8))
				hitLabels.add_child(tempHitLabel)
				averageKickablePos += kickable.get_global_position()
				kickable.kicked(kickVel)
			averageKickablePos /= toKick.size()
			velocity = (global_position - averageKickablePos).normalized() * kickForce
			KickAudio.play()
		elif touchingLeftWall:
			velocity = Vector2(1, -1).normalized()*kickForce
		elif touchingRightWall:
			velocity = Vector2(-1, -1).normalized()*kickForce
		else:
			missKicked = true

func checkToKick():
	toKick = []
	if !kickables.empty():
		#check if any kickable objects are blocked by an object
		for kickable in kickables:
			kickable.setHighlight(false)
			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_ray(global_position, kickable.get_global_position(), [self, kickable.get_parent()])
			if result != {}: 
				toKick.append(kickable)
				kickable.setHighlight(true)

func alive():
	checkToKick()
	
	#check if dead
	if !enemiesTouching.empty():
		if is_on_floor():
			print("lose")
			dead = true
			state = DEAD
			get_parent().gameOver()
	
	#coyote time reset
	if is_on_floor():
		jumpAvailable = true
	
	#one way collision check
	set_collision_mask_bit(3, true)
	if drop:
		set_collision_mask_bit(3, false)
	
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
	
	if Input.is_action_pressed("right"):
		accelDir = 1
	elif Input.is_action_pressed("left"):
		accelDir = -1

func _process(_delta):
	player_inputs()
	animation()
	match state:
		DEAD:
			if jumpPressed:
				get_tree().reload_current_scene()
			if Input.is_action_just_pressed("ui_cancel"):
				get_tree().change_scene("res://scenes/menus/LevelSelectMenu.tscn")

func _physics_process(_delta):
	match state:
		ALIVE:
			alive()
	
	move()


#kickable signals
func _on_KickArea_area_entered(area):
	kickables.append(area)
func _on_KickArea_area_exited(area):
	area.setHighlight(false)
	kickables.erase(area)

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

#coyote timeout
func _on_CoyoteTimer_timeout():
	jumpAvailable = false
