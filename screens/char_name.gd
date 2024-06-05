extends CanvasLayer

@onready var texture_rect = $CharsContainer/TextureRect
@onready var line_edit = $LineEdit

func _ready():
	texture_rect.texture = Globals.player.texture
	line_edit.grab_focus()
	if( Globals.player.textureId == 1):
		texture_rect.flip_h = true

func _on_start_game_button_pressed():
	_start_game()

func _on_back_button_pressed():
	TransitionScene.change_scene("res://screens/create_char.tscn")

func _start_game():
	if(line_edit.text == ""):
		Globals.player.name_text = "Player"
	else:	
		Globals.player.name_text = line_edit.text
	Repository.save_game()
		
	TransitionScene.change_scene("res://levels/level_1.tscn")
	
func _unhandled_key_input(event):
	if(event.keycode == KEY_ENTER):
		_start_game()
