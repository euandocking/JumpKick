extends Area2D

#variables
var kicked = false
var kickablesTouching = []

onready var RB = get_parent()
onready var KickHighlight = get_node("KickHighlight")

func setHighlight(value):
	KickHighlight.set_visible(value)

func kicked(vel):
	RB.kicked(vel)
	kicked = true

func _physics_process(_delta):
	if RB.velocity == Vector2.ZERO:
		kicked = false

#enemy collision check
func _on_HitArea_area_entered(area):
	if area != self:
		if kicked:
			area.kicked(RB.velocity*0.5)
			kicked(RB.velocity*-0.5)
		else:
			kickablesTouching.append(area)
func _on_HitArea_area_exited(area):
	kickablesTouching.erase(area)
