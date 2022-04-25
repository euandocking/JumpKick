extends Node2D

#component references
#kinematic body
onready var CrateBody = get_node("CrateBody")
#sprite
onready var CrateSprite = get_node("CrateSprite")
#kickable component
onready var Kickable = get_node("Kickable")

#update function
func _process(_delta):
	#updates entire node position based on relative physics body movement
	set_position(position + CrateBody.get_position())
	CrateBody.set_position(Vector2.ZERO)

#physics update
func _physics_process(_delta):
	#passes the body velocity to the kickable component
	Kickable.velocity = CrateBody.velocity

#returns the objects physics body
func getBody():
	return CrateBody

#on kick signal
func _on_Kickable_kicked(kickVel):
	#apply the kick velocity to the physics body
	getBody().velocity = kickVel
