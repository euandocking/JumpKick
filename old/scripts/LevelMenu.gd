extends VBoxContainer

func _ready():
	$LevelScroll/MenuOptions.get_children()[0].grab_focus()
