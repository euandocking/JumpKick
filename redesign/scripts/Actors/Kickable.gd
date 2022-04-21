extends Node2D

onready var KickableHighlight = get_node("KickableHighlight")
onready var KickableArea = get_node("KickableArea")

signal kicked(kickVel)

func showKickableHighlight(value):
	KickableHighlight.set_visible(value)

func kicked(kickVel):
	emit_signal("kicked", kickVel)
