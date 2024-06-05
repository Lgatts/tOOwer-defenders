class_name Repository

static func save_game():
	var save_game_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var player_string = PlayerMapper.player_to_json(Globals.player)
	save_game_file.store_line(player_string)
	save_game_file.close()

static func load_game():
	if not has_save():
		return
	
	var save_game_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	PlayerMapper.json_to_player(save_game_file.get_line())
	
static func has_save() -> bool:
	return FileAccess.file_exists("user://savegame.save")
