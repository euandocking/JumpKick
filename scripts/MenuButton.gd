extends Button

export(String) var buttonText = "Button"

func _ready():
	get_node("Label").set_text(buttonText)
