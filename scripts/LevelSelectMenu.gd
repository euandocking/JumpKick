extends VBoxContainer

#level selected signal
signal levelSelected(levelPath)

#pass up the relevant level on button presses
func _on_StreetsButton_pressed():
	emit_signal("levelSelected", "res://scenes/levels/StreetsLevel.tscn")
func _on_WarehouseButton_pressed():
	emit_signal("levelSelected", "res://scenes/levels/WarehouseLevel.tscn")
func _on_ApartmentButton_pressed():
	emit_signal("levelSelected", "res://scenes/levels/ApartmentLevel.tscn")
func _on_ClubButton_pressed():
	emit_signal("levelSelected", "res://scenes/levels/ClubLevel.tscn")
