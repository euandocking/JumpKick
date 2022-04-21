extends Node2D

var accelDir
var faceDir
var velocity

var kickSpeed

var touchingLeftWall
var touchingRightWall

var kickablesInArea
var kickablesInSight

onready var PlayerSprite = get_node("PlayerSprite")
onready var PlayerBody = get_node("PlayerBody")
onready var KickAudio = get_node("KickAudio")
onready var HitLabels = get_node("HitLabels")

onready var HitLabel = preload("res://redesign/scenes/HitLabel.tscn")

func _ready():
	accelDir = 0
	faceDir = 0
	velocity = Vector2.ZERO
	
	kickSpeed = 1800
	
	touchingLeftWall = false
	touchingRightWall = false
	
	kickablesInArea = []
	kickablesInSight = []

func _process(_delta):
	set_position(position + PlayerBody.get_position())
	PlayerBody.set_position(Vector2.ZERO)
	
	#determine accel direction
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
	
	PlayerBody.accelDir = accelDir
	
	#set face direction
	if accelDir != 0:
		faceDir = accelDir
	
	#determine kickables in sight
	checkKickables()
	
	if Input.is_action_just_pressed("jump"):
		if PlayerBody.is_on_floor():
			PlayerBody.jump()
		elif touchingLeftWall:
			PlayerBody.wallJump(1, kickSpeed)
		elif touchingRightWall:
			PlayerBody.wallJump(-1, kickSpeed)
		elif !kickablesInSight.empty():
			var averageKickablePos = Vector2.ZERO
			for kickable in kickablesInSight:
				averageKickablePos += kickable.get_global_position()
				var kickVel = (kickable.get_global_position() - global_position).normalized() * kickSpeed
				kickable.kicked(kickVel)
				var tempHitLabel = HitLabel.instance()
				tempHitLabel.set_rotation(-kickVel.angle_to(Vector2(0,1)))
				tempHitLabel.set_global_position(kickable.get_global_position().linear_interpolate(global_position, 0.8))
				HitLabels.add_child(tempHitLabel)
			averageKickablePos /= kickablesInSight.size()
			PlayerBody.kick((global_position - averageKickablePos).normalized() * kickSpeed)
			KickAudio.play()
	
	#animate sprite
	if faceDir == 1:
		PlayerSprite.set_flip_h(false)
	else:
		PlayerSprite.set_flip_h(true)

func _physics_process(_delta):
	velocity = PlayerBody.velocity

func checkKickables():
	kickablesInSight = []
	var space_state = get_world_2d().direct_space_state
	for kickable in kickablesInArea:
		#set highlight to false
		kickable.showKickableHighlight(false)
		var result = space_state.intersect_ray(global_position, kickable.get_global_position(), [PlayerBody])
		if result.has("collider"):
			if result.collider == kickable.get_parent().getBody():
				kickable.showKickableHighlight(true)
				kickablesInSight.append(kickable)

func _on_RightArea_body_entered(_body):
	touchingRightWall = true
func _on_RightArea_body_exited(_body):
	touchingRightWall = false

func _on_LeftArea_body_entered(_body):
	touchingLeftWall = true
func _on_LeftArea_body_exited(_body):
	touchingLeftWall = false

func _on_KickArea_area_entered(area):
	kickablesInArea.append(area.get_parent())
func _on_KickArea_area_exited(area):
	kickablesInArea.erase(area.get_parent())
	area.get_parent().showKickableHighlight(false)
