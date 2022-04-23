extends VBoxContainer

onready var SoundSlider = get_node("SoundSlider")
onready var SoundSliderLabel = get_node("SoundSliderLabel")

var focusStyle

signal valueChanged(value)

func _ready():
	focusStyle = load("res://styleboxes/menuFocus.tres")

func _on_MenuSliderBox_focus_entered():
	SoundSliderLabel.add_stylebox_override("focus", focusStyle)
	SoundSlider.grab_focus()

func _on_MenuSlider_value_changed(value):
	emit_signal("valueChanged", value)
