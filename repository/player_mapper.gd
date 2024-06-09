class_name PlayerMapper

static func player_to_json(player:Player) -> String:	
	var dict = {
		"max_health": player.max_health,
		"name_text": player.name_text,
		"texture": player.texture.resource_path,
		"textureId": player.textureId,
		"gold": player.gold,
		"inventory": map_inventory_to_dict(player),
		"cleared_levels": player.cleared_levels
	}
	return JSON.stringify(dict)

static func map_inventory_to_dict(player: Player):
	var array_tower = []
	for tower in player.inventory:
		array_tower.append(TowerMapper.tower_to_dict(tower))
	return array_tower

static func json_to_player(player_string: String):
	var player_dict = JSON.parse_string(player_string)
	Globals.player = Player.new()
	Globals.player.max_health = player_dict["max_health"]
	Globals.player.name_text = player_dict["name_text"]
	Globals.player.texture = load(player_dict["texture"])
	Globals.player.textureId = player_dict["textureId"]
	Globals.player.gold = player_dict["gold"]
	Globals.player.inventory = map_dict_to_inventory(player_dict["inventory"])
	Globals.player.cleared_levels = player_dict["cleared_levels"]

static func map_dict_to_inventory(inventory_dict) -> Array[Tower]:
	var inventory: Array[Tower] = []
	for tower_dict in inventory_dict:
		inventory.append(TowerMapper.from_dict_to_tower(tower_dict))
	return inventory
