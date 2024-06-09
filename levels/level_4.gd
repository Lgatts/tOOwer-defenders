extends Level

func _ready():
	super._ready()
	var waves = [
		Wave.new(5, skeleton, Enums.Elements.FIRE),
		Wave.new(2, skeleton, Enums.Elements.FIRE),
		Wave.new(4, skeleton, Enums.Elements.FIRE)
	]
	self._waves_controller = WavesController.new(waves)

func _on_complete_level():
	if(Globals.player.inventory.size() == 4):
		Globals.player.inventory.append(Tower.new(Enums.Elements.WIND))
	Globals.player.cleared_levels["level_4"] = Enums.LevelState.CLEARED
	if(Globals.player.cleared_levels["level_5"] == Enums.LevelState.DISABLED):
		Globals.player.cleared_levels["level_5"] = Enums.LevelState.ENABLED	
	Repository.save_game()
