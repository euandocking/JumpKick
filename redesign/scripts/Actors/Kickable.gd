extends Node2D

var velocity
var kicked
var enemiesTouching

onready var KickableHighlight = get_node("KickableHighlight")

signal kicked(kickVel)

func _ready():
	kicked = false
	velocity = Vector2.ZERO
	enemiesTouching = []

func _physics_process(delta):
	if kicked:
		if velocity == Vector2.ZERO:
			kicked = false
		elif !enemiesTouching.empty():
			for enemy in enemiesTouching:
				enemy.stunned()

func showKickableHighlight(value):
	KickableHighlight.set_visible(value)

func kicked(kickVel):
	kicked = true
	emit_signal("kicked", kickVel)

func _on_StunArea_area_entered(area):
	enemiesTouching.append(area.get_parent())
func _on_StunArea_area_exited(area):
	enemiesTouching.erase(area.get_parent())
