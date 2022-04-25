extends VBoxContainer

#auto selects the first button in menu
func _ready():
	if get_child(0) != null:
		get_child(0).grab_focus()
