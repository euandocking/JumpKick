extends Node2D

var kickVel

onready var KickableHighlight = get_node("KickableHighlight")

signal kicked

func showKickableHighlight(value):
	KickableHighlight.set_visible(value)

func kicked(velocity):
	kickVel = velocity
	emit_signal("kicked")
