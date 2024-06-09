extends Level

func _ready():
	super._ready()
	var waves = [
		Wave.new(1, golem, Enums.Elements.FIRE),
		Wave.new(10, skeleton, Enums.Elements.FIRE),
		Wave.new(20, skeleton, Enums.Elements.FIRE),
		Wave.new(2, bat, Enums.Elements.FIRE),
		Wave.new(1, golem, Enums.Elements.FIRE),
	]
	self._waves_controller = WavesController.new(waves)

func _on_complete_level():
	if(Globals.player.inventory.size() == 1):
		Globals.player.inventory.append(Tower.new(Enums.Elements.WATER))
	Globals.player.cleared_levels["level_1"] = Enums.LevelState.CLEARED
	if(Globals.player.cleared_levels["level_2"] == Enums.LevelState.DISABLED):
		Globals.player.cleared_levels["level_2"] = Enums.LevelState.ENABLED
	Repository.save_game()
	
