extends Control

@onready var sub_class = %SubClass
@onready var option_button = $OptionButton
@onready var selected_tower:Tower 
@onready var check_button = $CheckButton
var _override_element:bool = true

var names = {
	Enums.Elements.FIRE: "Fogo",
	Enums.Elements.WATER: "Gelo",
	Enums.Elements.EARTH: "Terra",
	Enums.Elements.WIND: "Vento",
	Enums.Elements.NEUTRAL: "Neutro",
}

var icons = {
	Enums.Elements.FIRE: load("res://assets/ui/TowerFireBIG.png"),
	Enums.Elements.WATER: load("res://assets/ui/TowerWaterBIG.png"),
	Enums.Elements.EARTH: load("res://assets/ui/TowerEarthBIG.png"),
	Enums.Elements.WIND: load("res://assets/ui/TowerWindBIG.png"),
	Enums.Elements.NEUTRAL: load("res://assets/ui/TowerNeutralBIG.png")
}

func create(tower: Tower):
	selected_tower = tower
	sub_class.texture = selected_tower._icon
	load_parent_class_options()
	_override_element = true
	check_button.button_pressed = true
	self.visible = true
	
func load_parent_class_options():
	option_button.clear()
	var id: int = 0	
	if(selected_tower._parent != Enums.Elements.UNDEFINED):
		option_button.add_icon_item(load("res://assets/ui/Trashbin.png"), "Remover", id)
		option_button.set_item_metadata(id, Tower.new(Enums.Elements.UNDEFINED))
		check_button.visible = false
		id+= 1
	else:
		check_button.visible = true

	for tower in Globals.player.inventory:
		if(tower._element != selected_tower._element):			
			option_button.add_icon_item(icons[tower._element], names[tower._element], id)
			option_button.set_item_metadata(id, tower)
			id+= 1

func _on_make_inheritance_button_pressed():
	selected_tower.add_parent(option_button.get_selected_metadata()._element, _override_element)
	self.visible = false

func _on_check_button_toggled(toggled_on):
	_override_element = toggled_on

func _on_option_button_item_selected(index):
	if (option_button.get_item_metadata(index)._element == Enums.Elements.UNDEFINED):
		check_button.visible = false
		_override_element = false
	else:
		check_button.visible = true

func _on_close_button_pressed():
	self.visible = false
