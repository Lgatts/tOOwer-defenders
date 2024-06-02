extends TextureRect

@onready var char_1 = $"."

signal char_selected(id:int)

@export var _id: int

var _focused_color = Color(1,1,1)
var _unfocused_color = Color(0.204, 0.204, 0.204)
var _selected = false

func _on_mouse_entered():
	char_1.modulate = _focused_color

func _on_mouse_exited():
	if(!_selected):
		unselect()

func _on_gui_input(event):
	if(Globals._isLeftClickMouse(event)):
		_selected = true
		char_selected.emit(_id)
		Globals.player.texture = self.texture
		Globals.player.textureId = _id
		TransitionScene.change_scene("res://screens/char_name.tscn")

func unselect():
	_selected = false
	char_1.modulate = _unfocused_color
