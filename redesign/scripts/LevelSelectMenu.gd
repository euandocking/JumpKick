extends VBoxContainer

signal levelSelected(levelPath)

func _on_StreetsButton_pressed():
	emit_signal("levelSelected", "res://redesign/scenes/levels/StreetsLevel.tscn")
func _on_WarehouseButton_pressed():
	emit_signal("levelSelected", "res://redesign/scenes/levels/WarehouseLevel.tscn")
func _on_ApartmentButton_pressed():
	emit_signal("levelSelected", "res://redesign/scenes/levels/ApartmentLevel.tscn")
func _on_ClubButton_pressed():
	emit_signal("levelSelected", "res://redesign/scenes/levels/ClubLevel.tscn")
func _on_TowerButton_pressed():
	pass # Replace with function body.
