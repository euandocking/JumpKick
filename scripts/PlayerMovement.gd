extends KinematicBody2D

#variables
var accel = 200
var maxRunSpeed = 500
var decel = 100
var jumpForce = 1000
var kickForce = 1200
var jumpGrav = 40
var upGrav = 60
var downGrav = 70
var velocity = Vector2.ZERO
var runDir = 0
var faceDir = 1
var jumpPressed = false
var jumpHeld = false
var kicked = false
var missKicked = false
var kickables = []
onready var PlayerSprite = get_node("PlayerSprite")
onready var KickArea = get_node("KickArea")
var playerTexture = preload("res://sprites/player.png")
var playerKickReadyTexture = preload("res://sprites/player_kick_ready.png")

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass

func player_inputs():
	if Input.is_action_just_pressed("left"):
		runDir = -1
	if Input.is_action_just_pressed("right"):
		runDir = 1
	if Input.is_action_just_released("left"):
		if Input.is_action_pressed("right"):
			runDir = 1
		else:
			runDir = 0
	if Input.is_action_just_released("right"):
		if Input.is_action_pressed("left"):
			runDir = -1
		else:
			runDir = 0
	if runDir != 0:
		faceDir = runDir
	
	if Input.is_action_just_pressed("jump"):
		jumpPressed = true
	else:
		jumpPressed = false
	if Input.is_action_pressed("jump"):
		jumpHeld = true
	else:
		jumpHeld = false

func animation():
	if kickables.empty():
		PlayerSprite.set_texture(playerTexture)
	else:
		PlayerSprite.set_texture(playerKickReadyTexture)
	if faceDir == 1:
		PlayerSprite.set_flip_h(false)
	elif faceDir == -1:
		PlayerSprite.set_flip_h(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	player_inputs()
	animation()

func _physics_process(_delta):
	var grav = 0
	var newVel = velocity
	if is_on_floor():
		kicked = false
		missKicked = false
	
	if runDir == 1:
		KickArea.set_position(Vector2(32,32))
		if newVel.x < maxRunSpeed:
			newVel.x += accel
	elif runDir == -1:
		KickArea.set_position(Vector2(-32,32))
		if newVel.x > -maxRunSpeed:
			newVel.x -= accel
	else:
		if abs(newVel.x) > accel:
			newVel.x -= sign(newVel.x) * decel
		else:
			newVel.x = 0
	
	if !kicked:
		velocity = newVel
	else:
		velocity = velocity.linear_interpolate(newVel, 0.5)
	
	if velocity.y < 0:
		if jumpHeld:
			grav = jumpGrav
		else:
			grav = upGrav
	else:
		grav = downGrav
	velocity.y += grav
	
	if jumpPressed:
		if is_on_floor():
			velocity.y = -jumpForce
		elif !missKicked:
			if !kickables.empty():
				kicked = true
				velocity = (global_position - kickables[0].get_global_position()).normalized() * kickForce
			else:
				missKicked = true
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_KickArea_body_entered(body):
	kickables.append(body)


func _on_KickArea_body_exited(body):
	kickables.erase(body)