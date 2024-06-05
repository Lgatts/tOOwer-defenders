extends CanvasLayer

@onready var chars_container = $CharsContainer

func _ready():
	for _char in chars_container.get_children():
		_char.connect("char_selected", _char_selected)
		
func _char_selected():
	TransitionScene.change_scene("res://screens/char_name.tscn")
