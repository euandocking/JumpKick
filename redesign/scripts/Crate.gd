extends Node2D

onready var CrateBody = get_node("CrateBody")
onready var CrateSprite = get_node("CrateSprite")
onready var Kickable = get_node("Kickable")

func _process(_delta):
	set_position(position + CrateBody.get_position())
	CrateBody.set_position(Vector2.ZERO)

func _physics_process(delta):
	Kickable.velocity = CrateBody.velocity

func getBody():
	return CrateBody

func _on_Kickable_kicked(kickVel):
	getBody().velocity = kickVel
