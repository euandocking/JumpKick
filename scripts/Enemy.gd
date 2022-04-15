extends "Actor.gd"

#signals
signal died
signal detectedPlayer
signal playerEscaped

#variables
var PlayerBody
var playerInArea = false
var runAccel = 150
var walkAccel = 50
var maxRunSpeed = 550
var maxWalkSpeed = 300

export (NodePath) var PatrolPath
var PatrolPoints
var patrolIndex = 0
onready var EnemySprite = get_node("EnemySprite")

var EnemyTexture = preload("res://sprites/enemy.png")
var EnemyDeadTexture = preload("res://sprites/enemy_dead.png")

enum {
	PATROL,
	ATTACK,
	DEAD
}

var state = PATROL

func setPlayer(player):
	PlayerBody = player

func kicked(vel):
	if state != DEAD:
		set_collision_layer_bit(4, false)
		set_collision_mask_bit(4, false)
		accelDir = 0
		state = DEAD
		get_parent()._on_EnemyBody_died()
	velocity = vel

func patrol():
	#movement
	if PatrolPath:
		var targetPoint = PatrolPoints[patrolIndex]
		if position.distance_to(targetPoint) < maxAccelSpeed:
			patrolIndex = wrapi(patrolIndex + 1, 0, PatrolPoints.size())
			targetPoint = PatrolPoints[patrolIndex]
		var newDir = sign(targetPoint.x - position.x)
		if accelDir != newDir:
			accelDir = newDir
			emit_signal("accelDirChanged")
	
	#detection check
	if PlayerBody:
		if !PlayerBody.is_dead():
			if playerInArea:
				if sign(PlayerBody.get_global_position().x - global_position.x) == faceDir:
					var space_state = get_world_2d().direct_space_state
					var result = space_state.intersect_ray(global_position, PlayerBody.get_global_position(), [self], 11)
					if result.collider == PlayerBody:
						emit_signal("detectedPlayer")

func attack():
	if PlayerBody.is_dead():
		state = PATROL
	
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, PlayerBody.get_global_position(), [self], 11)
	if playerInArea and (result.collider == PlayerBody):
		var toPlayer = PlayerBody.get_position().x - position.x
		if abs(toPlayer) > 32:
			var newDir = sign(toPlayer)
			if accelDir != newDir:
				accelDir = newDir
				emit_signal("accelDirChanged")
			if !PlayerBody.is_on_floor():
				if toPlayer < 96:
					accelDir = 0
	else:
		emit_signal("playerEscaped")

func _ready():
	accel = walkAccel
	maxAccelSpeed = maxWalkSpeed
	decel = 25
	grav = 50
	
	if PatrolPath:
		PatrolPoints = get_node(PatrolPath).curve.get_baked_points()

func _process(_delta):
	if state != DEAD:
		EnemySprite.set_texture(EnemyTexture)
	else:
		EnemySprite.set_texture(EnemyDeadTexture)
	if faceDir == 1:
		EnemySprite.flip_h = false
	elif faceDir == -1:
		EnemySprite.flip_h = true

func _physics_process(_delta):
	match state:
		PATROL:
			patrol()
		ATTACK:
			attack()
		DEAD:
			pass
	move()

#detection area checks
func _on_DetectionArea_body_entered(body):
	playerInArea = true
func _on_DetectionArea_body_exited(body):
	playerInArea = false

#detected player
func _on_EnemyBody_detectedPlayer():
	state = ATTACK
	accel = runAccel
	maxAccelSpeed = maxRunSpeed

#player escaped
func _on_EnemyBody_playerEscaped():
	state = PATROL
	accel = walkAccel
	maxAccelSpeed = maxWalkSpeed

#change direction
func _on_EnemyBody_accelDirChanged():
	if accelDir != 0:
		faceDir = accelDir
