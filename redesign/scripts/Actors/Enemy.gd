extends Node2D

var state

enum States { IDLE, DEAD }

onready var EnemyBody = get_node("EnemyBody")
onready var EnemySprite = get_node("EnemySprite")
onready var Kickable = get_node("Kickable")

signal defeated

func _ready():
	state = States.IDLE

func _process(_delta):
	set_position(position + EnemyBody.get_position())
	EnemyBody.set_position(Vector2.ZERO)

func getBody():
	return EnemyBody

func _on_Kickable_kicked():
	if state != States.DEAD:
		emit_signal("defeated")
		state = States.DEAD
	EnemyBody.velocity = Kickable.kickVel
