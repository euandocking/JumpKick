extends "Actor.gd"

#variables
var playerInArea = false
var PlayerBody
var faceDir = 1
var runAccel = 180
var walkAccel = 50
var maxRunSpeed = 580
var maxWalkSpeed = 300

signal died
signal detectedPlayer
signal playerEscaped

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

func _ready():
	accel = walkAccel
	maxAccelSpeed = maxWalkSpeed
	decel = 25
	grav = 50
	
	if PatrolPath:
		PatrolPoints = get_node(PatrolPath).curve.get_baked_points()

func kicked(vel):
	accelDir = 0
	velocity = vel
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(4, false)
	state = DEAD
	emit_signal("died")

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
			#patrol code
			if PatrolPath:
				var targetPoint = PatrolPoints[patrolIndex]
				if position.distance_to(targetPoint) < maxAccelSpeed:
					patrolIndex = wrapi(patrolIndex + 1, 0, PatrolPoints.size())
					targetPoint = PatrolPoints[patrolIndex]
				var newDir = sign(targetPoint.x - position.x)
				if accelDir != newDir:
					accelDir = newDir
					emit_signal("accelDirChanged")
			
			#detection code
			if playerInArea:
				if sign(PlayerBody.get_global_position().x - global_position.x) == faceDir:
					var space_state = get_world_2d().direct_space_state
					var result = space_state.intersect_ray(global_position, PlayerBody.get_global_position(), [self])
					if result.collider == PlayerBody:
						emit_signal("detectedPlayer")
						
		ATTACK:
			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_ray(global_position, PlayerBody.get_global_position(), [self])
			if playerInArea and (result.collider == PlayerBody):
				if abs(PlayerBody.get_position().x - position.x) > 32:
					var newDir = sign(PlayerBody.get_position().x - position.x)
					if accelDir != newDir:
						accelDir = newDir
						emit_signal("accelDirChanged")
			else:
				emit_signal("playerEscaped")
		DEAD:
			pass
	
	move()

#detection area checks
func _on_DetectionArea_body_entered(body):
	if body.get_name() == "Player":
		playerInArea = true
		PlayerBody = body
func _on_DetectionArea_body_exited(body):
	if body.get_name() == "Player":
		playerInArea = false

#detected player
func _on_EnemyBody_detectedPlayer():
	state = ATTACK
	accel = runAccel
	maxAccelSpeed = maxRunSpeed

#player left
func _on_EnemyBody_playerEscaped():
	state = PATROL
	accel = walkAccel
	maxAccelSpeed = maxWalkSpeed

func _on_EnemyBody_accelDirChanged():
	faceDir = accelDir
