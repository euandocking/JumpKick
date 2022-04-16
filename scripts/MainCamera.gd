extends Camera2D

export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)

func _process(_delta):
	if Player:
		position = position.linear_interpolate(Player.get_position()+Player.velocity*0.1, 0.1)
