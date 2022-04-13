extends Camera2D

export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)

func _process(_delta):
	if Player:
		position.x = Player.get_global_position().x
