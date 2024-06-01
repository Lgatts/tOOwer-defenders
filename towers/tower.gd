class_name Tower

signal parent_added

var _scene: PackedScene = load("res://towers/tower_scene.tscn")
var _icon: Texture2D
var _aura: Texture2D
var _parent_icon: Texture2D
var _element: Enums.Elements
var _damage: int = 1
var _parent: Enums.Elements = Enums.Elements.UNDEFINED
var _override_element: bool = false

var textures = {
	Enums.Elements.FIRE: load("res://assets/towers/TowerFire.png"),
	Enums.Elements.WATER: load("res://assets/towers/TowerWater.png"),
	Enums.Elements.EARTH: load("res://assets/towers/TowerEarth.png"),
	Enums.Elements.WIND: load("res://assets/towers/TowerWind.png"),
	Enums.Elements.NEUTRAL: load("res://assets/towers/TowerNeutral.png"),
	Enums.Elements.UNDEFINED: null
}

var aura_textures = {
	Enums.Elements.FIRE: load("res://assets/towers/AuraFire.png"),
	Enums.Elements.WATER: load("res://assets/towers/AuraWater.png"),
	Enums.Elements.EARTH: load("res://assets/towers/AuraEarth.png"),
	Enums.Elements.WIND: load("res://assets/towers/AuraWind.png"),
	Enums.Elements.NEUTRAL: load("res://assets/towers/AuraNeutral.png"),
	Enums.Elements.UNDEFINED: null
}

func _init(element: Enums.Elements):
	if(element != Enums.Elements.UNDEFINED):
		_icon = textures[element]
		if(element == Enums.Elements.NEUTRAL):
			_damage = 2
	_element = element
	
func instantiate():
	var instance = _scene.instantiate()
	instance.construct(_element,_icon, _damage, _parent, _aura, _override_element, _parent_icon)
	return instance

func add_parent(parent: Enums.Elements, override_element):
	_parent = parent
	_aura = aura_textures[_parent]
	_parent_icon = textures[_parent]
	_override_element = override_element
	parent_added.emit()
