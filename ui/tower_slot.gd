class_name TowerSlot
extends MarginContainer

signal select_tower(_tower:Tower, slot_global_position)

var _tower: Tower

var _aura_textures = {
	Enums.Elements.FIRE: load("res://assets/ui/AuraFireGUI.png"),
	Enums.Elements.WATER: load("res://assets/ui/AuraWaterGUI.png"),
	Enums.Elements.EARTH: load("res://assets/ui/AuraEarthGUI.png"),
	Enums.Elements.WIND: load("res://assets/ui/AuraWindGUI.png"),
	Enums.Elements.NEUTRAL: load("res://assets/ui/AuraNeutralGUI.png"),
	Enums.Elements.UNDEFINED: null
}

@onready
var _icon:TextureRect = $Icon

var _icon_texture

func _ready():
	_icon.texture = _icon_texture
	_tower.connect("parent_added", _on_parent_added)
	$Icon/AuraGui.texture = _aura_textures[_tower._parent]
	$Icon/AuraGui.visible = true

func _on_mouse_entered():
	$TextureRect2.visible = true

func _on_mouse_exited():
	$TextureRect2.visible = false

func _on_gui_input(event):
	if (event is InputEventMouseButton):      
		var mouse_event: InputEventMouseButton = event       
		if (mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed):
			select_tower.emit(_tower, self.global_position)
		if (mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_released()):
			pass

func construct(tower:Tower):
	_icon_texture = tower._icon
	_tower = tower

func _on_parent_added():
	$Icon/AuraGui.texture = _aura_textures[_tower._parent]
	$Icon/AuraGui.visible = true
