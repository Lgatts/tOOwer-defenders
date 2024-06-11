extends Level

func _ready():
	var waves = [
		Wave.new(4, skeleton, Enums.Elements.FIRE),
		Wave.new(10, skeleton, Enums.Elements.FIRE),
		Wave.new(20, skeleton, Enums.Elements.FIRE),
		Wave.new(1, bat, Enums.Elements.FIRE),
		Wave.new(1, golem, Enums.Elements.FIRE),
	]
	self._waves_controller = WavesController.new(waves)
	
	var programmer = "programador"
	if(Globals.player.textureId == 0):
		programmer = "programadora"
	Level1Dialog.dialogs[0]= Level1Dialog.dialogs[0].replace("{player_name}",Globals.player.name_text)
	Level1Dialog.dialogs[1] = Level1Dialog.dialogs[1].replace("{programador}", programmer)
	super._ready()
	chat.display_chat(Level1Dialog.dialogs)

func _on_complete_level():
	if(Globals.player.inventory.size() == 1):
		Globals.player.inventory.append(Tower.new(Enums.Elements.WATER))
	Globals.player.cleared_levels["level_1"] = Enums.LevelState.CLEARED
	if(Globals.player.cleared_levels["level_2"] == Enums.LevelState.DISABLED):
		Globals.player.cleared_levels["level_2"] = Enums.LevelState.ENABLED
	Globals.player.gold += 200	
	Repository.save_game()
