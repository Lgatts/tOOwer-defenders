extends Level

func _ready():	 
	chat.display_chat(Level3Dialog.dialogs3)
	super._ready()
	var waves = [
		Wave.new(10, skeleton, Enums.Elements.WATER),
		Wave.new(10, skeleton, Enums.Elements.EARTH),
		Wave.new(2, bat, Enums.Elements.WATER),
		Wave.new(15, skeleton, Enums.Elements.EARTH),
		Wave.new(2, golem, Enums.Elements.EARTH),
	]
	self._waves_controller = WavesController.new(waves)

func _on_complete_level():
	if(Globals.player.inventory.size() == 3):
		Globals.player.inventory.append(Tower.new(Enums.Elements.EARTH))
	Globals.player.cleared_levels["level_3"] = Enums.LevelState.CLEARED
	if(Globals.player.cleared_levels["level_4"] == Enums.LevelState.DISABLED):
		Globals.player.cleared_levels["level_4"] = Enums.LevelState.ENABLED
	Globals.player.gold += 600
	Repository.save_game()
