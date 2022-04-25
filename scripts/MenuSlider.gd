extends VBoxContainer

#components
onready var SoundSlider = get_node("SoundSlider")
onready var SoundSliderLabel = get_node("SoundSliderLabel")

#slider update signal
signal valueChanged(value)

#grab focus of slider
#necessary as slider also contains label above, so focus is not granted automatically
func _on_MenuSliderBox_focus_entered():
	SoundSlider.grab_focus()

#signals when slider value changed
func _on_MenuSlider_value_changed(value):
	emit_signal("valueChanged", value)
