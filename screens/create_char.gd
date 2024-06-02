extends CanvasLayer

@onready var chars_container = $CharsContainer

func _ready():
	for _char in chars_container.get_children():
		_char.connect("char_selected", _char_selected)		
		
func _char_selected(id:int):
	for _char in chars_container.get_children():
		if(_char._id != id):
			_char.unselect()
