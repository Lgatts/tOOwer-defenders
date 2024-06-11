extends Level

func _ready():
	Level2Dialog.dialogs2[0] = Level2Dialog.dialogs2[0].replace("{player_name}", Globals.player.name_text) 
	chat.display_chat(Level2Dialog.dialogs2)
	super._ready()
	var waves = [
		Wave.new(2, bat, Enums.Elements.FIRE),
		Wave.new(10, skeleton, Enums.Elements.NEUTRAL),
		Wave.new(10, skeleton, Enums.Elements.WATER),
		Wave.new(10, bat, Enums.Elements.FIRE),
		Wave.new(1, golem, Enums.Elements.WATER),
	]
	self._waves_controller = WavesController.new(waves)	

func _on_complete_level():
	if(Globals.player.inventory.size() == 2):
		Globals.player.inventory.append(Tower.new(Enums.Elements.FIRE))
	Globals.player.cleared_levels["level_2"] = Enums.LevelState.CLEARED
	if(Globals.player.cleared_levels["level_3"] == Enums.LevelState.DISABLED):
		Globals.player.cleared_levels["level_3"] = Enums.LevelState.ENABLED
	Globals.player.gold += 400
	Repository.save_game()
