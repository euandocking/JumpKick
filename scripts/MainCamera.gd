extends Camera2D

onready var PlayerBody = get_node("/root/Level/Player")

func _process(_delta):
	position.x = PlayerBody.get_global_position().x
