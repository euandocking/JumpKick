extends KinematicBody2D

#variables
var decel = 25
var grav = 50
var velocity = Vector2.ZERO
var playerInArea = false
var PlayerBody
var faceDir = 1

signal died

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

func set_velocity(vel):
	velocity = vel

func kicked(vel):
	velocity = vel
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(4, false)
	state = DEAD
	emit_signal("died")

# Called when the node enters the scene tree for the first time.
func _ready():
	if PatrolPath:
		PatrolPoints = get_node(PatrolPath).curve.get_baked_points()

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	if velocity.x > 0:
		faceDir = 1
	elif velocity.x < 0:
		faceDir = -1
	
	match state:
		PATROL:
			#patrol code
			if PatrolPath:
				var targetPoint = PatrolPoints[patrolIndex]
				if position.distance_to(targetPoint) < 350:
					patrolIndex = wrapi(patrolIndex + 1, 0, PatrolPoints.size())
					targetPoint = PatrolPoints[patrolIndex]
				velocity.x = sign(targetPoint.x - position.x) * 350
			
			#detection code
			if playerInArea:
				if sign(PlayerBody.get_global_position().x - global_position.x) == faceDir:
					var space_state = get_world_2d().direct_space_state
					var result = space_state.intersect_ray(global_position, PlayerBody.get_global_position(), [self])
					if result.collider == PlayerBody:
						state = ATTACK
						
		ATTACK:
			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_ray(global_position, PlayerBody.get_global_position(), [self])
			if playerInArea and (result.collider == PlayerBody):
				if abs(PlayerBody.get_position().x - position.x) > 32:
					velocity.x = sign(PlayerBody.get_position().x - position.x) * 500
			else:
				state = PATROL
		DEAD:
			pass
	
	if abs(velocity.x) > decel:
			velocity.x -= sign(velocity.x) * decel
	else:
		velocity.x = 0
	
	velocity.y += grav
	
	velocity = move_and_slide(velocity, Vector2.UP)



func _on_DetectionArea_body_entered(body):
	if body.get_name() == "Player":
		playerInArea = true
		PlayerBody = body


func _on_DetectionArea_body_exited(body):
	if body.get_name() == "Player":
		playerInArea = false
