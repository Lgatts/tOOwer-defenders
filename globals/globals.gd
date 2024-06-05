extends Node

signal enemies_change

var current_wave: int = 0:
	set(value):
		current_wave = value
		enemies_change.emit()
		
var total_waves: int = 0:
	set(value):
		total_waves = value
		enemies_change.emit()
		
var player: Player

var ui_state: Enums.States = Enums.States.DEFAULT

func _isLeftClickMouse(event) -> bool:
	return (event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT 
		and event.pressed)
