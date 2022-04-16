extends VBoxContainer

func _ready():
	$MenuOptions.get_children()[0].grab_focus()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/menus/MainMenu.tscn")
