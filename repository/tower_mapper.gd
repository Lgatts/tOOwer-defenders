class_name TowerMapper

static func tower_to_dict(tower: Tower):
	var tower_dict = {
		"_element": tower._element
	}
	return tower_dict

static func from_dict_to_tower(tower_dict):
	return Tower.new(tower_dict["_element"])
