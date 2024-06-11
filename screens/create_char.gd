extends CanvasLayer

@onready var chars_container = $CharsContainer
@onready var audio_stream_player = $AudioStreamPlayer

func _ready():
	audio_stream_player.play(Globals.audio_position)
	for _char in chars_container.get_children():
		_char.connect("char_selected", _char_selected)
		
func _char_selected():
	Globals.audio_position = audio_stream_player.get_playback_position()
	TransitionScene.change_scene("res://screens/char_name.tscn")

func _on_back_button_pressed():
	TransitionScene.change_scene("res://game.tscn")
