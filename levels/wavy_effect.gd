extends RichTextLabel

@export var amplitude: float
@export var frequency: float
var base_text: String

func _ready():
	bbcode_enabled = true
	base_text = text
	
func _process(_delta):
	text ="[wave amp=%d freq=%.2f]%s[/wave]" % [amplitude, frequency, base_text]
	 
