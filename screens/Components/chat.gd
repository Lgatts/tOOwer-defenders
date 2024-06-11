extends CanvasLayer

signal dialog_finished

@onready var rich_text_label = %ChatText

var texts: Array[String] = [""]
var current_speed = 200
var current_text = 0
var text_length = 0
var started = false
@onready var chat_music = $ChatMusic

func _ready():	
	rich_text_label.visible_ratio = 0
	rich_text_label.visible_characters_behavior = TextServer.VisibleCharactersBehavior.VC_CHARS_AFTER_SHAPING

func display_chat(dialogs):
	texts = dialogs
	rich_text_label.text = texts[current_text]
	text_length = rich_text_label.get_total_character_count()
	started = true
	chat_music.play()

func _process(delta):
	if(started):
		rich_text_label.visible_ratio += delta * 0.1 * current_speed / text_length

func _on_next_button_pressed():
	if(rich_text_label.visible_ratio < 1.0):
		rich_text_label.visible_ratio = 1.0
	else:
		current_text += 1
		if(texts.size() > current_text):
			rich_text_label.visible_ratio = 0
			rich_text_label.text = texts[current_text]
			text_length = rich_text_label.get_total_character_count()
		else:
			chat_music.stop()
			dialog_finished.emit()
			queue_free()

func _on_skip_button_pressed():
	dialog_finished.emit()
	queue_free()
