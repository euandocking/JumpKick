extends VBoxContainer

func _on_FullscreenToggleButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
func _on_MenuSliderBox_valueChanged(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), value/100*40)
func _on_MusicSliderBox_valueChanged(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value/100*40)
