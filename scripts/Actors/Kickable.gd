extends Node2D

#variables
var velocity
var beenKicked
var enemiesTouching

#highlight component
onready var KickableHighlight = get_node("KickableHighlight")

#kicked signal
signal kicked(kickVel)

#on start
func _ready():
	#initialise variables
	beenKicked = false
	velocity = Vector2.ZERO
	enemiesTouching = []

#physics update
func _physics_process(_delta):
	#if been kicked
	if beenKicked:
		#if stopped
		if velocity == Vector2.ZERO:
			#mark as not been kicked
			beenKicked = false
		#else if colliding with enemies
		elif !enemiesTouching.empty():
			#for each enemy touching
			for enemy in enemiesTouching:
				#stun the enemy
				enemy.stunned()

#shows/hides a highlight around the object
func showKickableHighlight(value):
	KickableHighlight.set_visible(value)

#kicked function
func kicked(kickVel):
	#set been kicked
	beenKicked = true
	#emit kick signal with velocity as parameter
	emit_signal("kicked", kickVel)

#track enemies colliding with
func _on_StunArea_area_entered(area):
	enemiesTouching.append(area.get_parent())
func _on_StunArea_area_exited(area):
	enemiesTouching.erase(area.get_parent())
