extends KinematicBody2D

#variables
var decel = 25
var grav = 50
var velocity = Vector2.ZERO
var playerInArea = false
var PlayerBody
var faceDir = 1

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
	state = DEAD

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	pass

func _physics_process(_delta):
	match state:
		PATROL:
			pass
			#move from point a to point b
			if playerInArea:
				if sign(PlayerBody.get_global_position().x - global_position.x) == faceDir:
					var space_state = get_world_2d().direct_space_state
					var result = space_state.intersect_ray(global_position, PlayerBody.get_global_position(), [self])
					if result.collider == PlayerBody:
						state = ATTACK
		ATTACK:
			pass
			#if touching player
				#if player on ground
					#game over
			#if player is on path
				#move towards player position via path
				
		DEAD:
			pass
	
	if abs(velocity.x) > decel:
			velocity.x -= sign(velocity.x) * decel
	else:
		velocity.x = 0
	
	velocity.y += grav
	
	velocity = move_and_slide(velocity, Vector2.UP)



func _on_DetectionArea_body_entered(body):
	if body.get_name() == "PlayerBody":
		playerInArea = true
		PlayerBody = body
