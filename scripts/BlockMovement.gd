extends KinematicBody2D

#variables
var decel = 25
var grav = 50
var velocity = Vector2.ZERO

func set_velocity(vel):
	velocity = vel
	
func kicked(vel):
	velocity = vel

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	pass

func _physics_process(_delta):
	if abs(velocity.x) > decel:
			velocity.x -= sign(velocity.x) * decel
	else:
		velocity.x = 0
	
	velocity.y += grav
	
	velocity = move_and_slide(velocity, Vector2.UP)

