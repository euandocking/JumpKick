extends Node2D

var state
var patrolIndex

var patrolAccel
var attackAccel
var patrolMaxSpeed
var	attackMaxSpeed

enum States { PATROL, ATTACK, STUNNED, DEAD }

export(NodePath) var AttackAreaPath
export(NodePath) var PatrolRoutePath

var PatrolPoints 
var lastPoint
var nextPoint

var AttackArea
var Player

var faceDir
var playerInArea

onready var EnemyBody = get_node("EnemyBody")
onready var EnemySprite = get_node("EnemySprite")
onready var Kickable = get_node("Kickable")
onready var StunnedTimer = get_node("StunnedTimer")

signal defeated

func _ready():
	if PatrolRoutePath:
		PatrolPoints = get_node(PatrolRoutePath).get_children()
	if AttackAreaPath:
		AttackArea = get_node(AttackAreaPath)
	
	if PatrolPoints:
		patrolIndex = 0
		lastPoint = PatrolPoints[wrapi(patrolIndex - 1, 0, PatrolPoints.size())]
		nextPoint = PatrolPoints[patrolIndex]
	
	state = States.PATROL
	
	patrolAccel = 150
	attackAccel = 200
	patrolMaxSpeed = 400
	attackMaxSpeed = 800
	faceDir = 1
	playerInArea = false

func _process(_delta):
	match state:
		States.ATTACK:
			animate()
		States.PATROL:
			animate()
	#set face direction
	if EnemyBody.accelDir != 0:
		faceDir = EnemyBody.accelDir

func _physics_process(_delta):
	set_position(position + EnemyBody.get_position())
	EnemyBody.set_position(Vector2.ZERO)
	
	Kickable.velocity = EnemyBody.velocity
	
	match state:
		States.ATTACK:
			attack()
		States.PATROL:
			patrol()

func animate():
	if faceDir == 1:
		EnemySprite.set_flip_h(false)
	else:
		EnemySprite.set_flip_h(true)

func patrol():
	if PatrolPoints:
		var pathDir = sign(nextPoint.position.x - lastPoint.position.x)
		var newDir = sign(nextPoint.position.x - position.x)
		if newDir != pathDir:
			patrolIndex = wrapi(patrolIndex + 1, 0, PatrolPoints.size())
			lastPoint = PatrolPoints[wrapi(patrolIndex - 1, 0, PatrolPoints.size())]
			nextPoint = PatrolPoints[patrolIndex]
			newDir = sign(nextPoint.position.x - position.x)
		EnemyBody.accelDir = newDir
	
	#detection check
	if Player:
		if Player.state != Player.States.DEAD:
			if playerInArea:
				if sign(Player.get_global_position().x - global_position.x) == faceDir:
					var space_state = get_world_2d().direct_space_state
					var result = space_state.intersect_ray(global_position, Player.get_global_position(), [EnemyBody, Player.PlayerBody])
					if result.empty():
						state = States.ATTACK
						EnemyBody.maxAccelSpeed = attackMaxSpeed
						EnemyBody.accel = attackAccel
						EnemySprite.animation = "attack"

func attack():
	if AttackArea:
		EnemyBody.accelDir = 0
		if AttackArea.playerInArea:
			var toPlayer = Player.global_position - global_position
			if abs(toPlayer.x) > 16:
				EnemyBody.accelDir = sign(toPlayer.x)
	
	#detection check
	if Player:
		if !playerInArea or Player.state == Player.States.DEAD:
			state = States.PATROL
			EnemyBody.maxAccelSpeed = patrolMaxSpeed
			EnemyBody.accel = patrolAccel

func getBody():
	return EnemyBody

func stunned():
	if state != States.DEAD:
		state = States.STUNNED
		StunnedTimer.start(1)
		EnemyBody.accelDir = 0
		EnemyBody.set_collision_layer_bit(4, false)
		EnemySprite.animation = "stunned"

func _on_Kickable_kicked(kickVel):
	if state != States.DEAD:
		emit_signal("defeated")
		EnemyBody.accelDir = 0
		state = States.DEAD
		EnemyBody.set_collision_layer_bit(4, false)
		EnemySprite.animation = "dead"
	getBody().velocity = kickVel


func _on_DetectionArea_body_entered(_body):
	playerInArea = true
func _on_DetectionArea_body_exited(_body):
	playerInArea = false

func _on_StunnedTimer_timeout():
	if state != States.DEAD:
		state = States.ATTACK
		EnemyBody.set_collision_layer_bit(4, true)
		EnemySprite.animation = "attack"
		EnemyBody.maxAccelSpeed = attackMaxSpeed
		EnemyBody.accel = attackAccel
