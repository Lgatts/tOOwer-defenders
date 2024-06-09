extends Node

@onready var damage_origin = $"."
var _label_settings: LabelSettings

var _font_color = {
	Enums.AttackType.NORMAL: Color(1,1,1),
	Enums.AttackType.WEAK: Color(0.816, 0.2, 0.204),
	Enums.AttackType.STRONG: Color(0.89, 0.882, 0.102)
}

func _ready():
	var font = FontFile.new()
	font.font_data = load("res://assets/fonts/CheerfulMorning.otf")
	_label_settings = LabelSettings.new()
	_label_settings.font = font
	_label_settings.font_size = 30
	_label_settings.outline_size = 5
	_label_settings.outline_color = Color(0,0,0)

func display_damage(value: int, attack_type: Enums.AttackType):
	var number = Label.new()
	number.position = damage_origin.position
	number.text = str(value)
	number.z_index = 5
	number.label_settings = _label_settings
	
	number.label_settings.font_color = _font_color[attack_type]
		
	call_deferred("add_child", number)

	await number.resized
	number.pivot_offset = Vector2(number.size /2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await tween.finished
	number.queue_free()
