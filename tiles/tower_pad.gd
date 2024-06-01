@tool
extends Area2D
class_name TowerPad

@export
var _element: Enums.Elements = Enums.Elements.NEUTRAL
var has_turret = false

var textures = {
	Enums.Elements.FIRE: load("res://assets/tiles/TowerPadFire.png"),
	Enums.Elements.WATER: load("res://assets/tiles/TowerPadWater.png"),
	Enums.Elements.EARTH: load("res://assets/tiles/TowerPadEarth.png"),
	Enums.Elements.WIND: load("res://assets/tiles/TowerPadWind.png"),
	Enums.Elements.NEUTRAL: load("res://assets/tiles/TowerPadNeutral.png")
}

func _ready():
	$Texture.texture = textures[_element]

func _on_area_entered(area):
	if((area._element == _element or area._parent == _element) and !has_turret):
		area.range_indicator.update_color(Color(0, 1, 0, 0.5))
		area.can_be_placed = true
		area.current_tower_pad = self

func _on_area_exited(area):
	area.range_indicator.update_color(Color(1, 0, 0, 0.5))
	area.can_be_placed = false
	area.current_tower_pad = null
