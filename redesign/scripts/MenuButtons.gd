extends VBoxContainer

func _ready():
	if get_child(0) != null:
		get_child(0).grab_focus()
