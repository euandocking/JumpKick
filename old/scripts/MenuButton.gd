extends Button

var focus = false

export(String) var buttonText = "Button"

func _ready():
	get_node("Label").set_text(buttonText)

func _process(delta):
	if has_focus():
		get_node("Background").color = Color(0, 0, 0)
	else:
		get_node("Background").color = Color(0.1, 0.1, 0.1)
