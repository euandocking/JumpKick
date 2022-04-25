extends VBoxContainer

#invincibility toggle signal
signal invincibilityToggled

#fullscreen toggle
func _on_FullscreenToggleButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
#audio slider update
#slider is from -100 to 0, so result is percentage of -40 to 0 dB
func _on_MenuSliderBox_valueChanged(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), value/100*40)
#music slider update
#slider is from -100 to 0, so result is percentage of -40 to 0 dB
func _on_MusicSliderBox_valueChanged(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value/100*40)
#invincibility toggle
func _on_InvincibilityButton_pressed():
	emit_signal("invincibilityToggled")
