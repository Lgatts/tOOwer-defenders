extends TextureRect

@onready var background = $Background
signal clicked

func _on_mouse_entered():
	background.visible = true

func _on_mouse_exited():
	background.visible = false

func _on_gui_input(event):
	if(_isLeftClickMouse(event)):
		clicked.emit()

func _isLeftClickMouse(event) -> bool:
	return (event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT 
		and event.pressed)
