extends Level

func _ready():
	super._ready()
	var waves = [
		Wave.new(2, bat, Enums.Elements.FIRE),
		Wave.new(10, skeleton, Enums.Elements.WATER),
		Wave.new(2, bat, Enums.Elements.FIRE),
		Wave.new(15, skeleton, Enums.Elements.FIRE),
		Wave.new(2, bat, Enums.Elements.NEUTRAL),
	]
	self._waves_controller = WavesController.new(waves)

func _on_complete_level():
	if(Globals.player.inventory.size() == 3):
		Globals.player.inventory.append(Tower.new(Enums.Elements.EARTH))
	Globals.player.cleared_levels["level_3"] = Enums.LevelState.CLEARED
	if(Globals.player.cleared_levels["level_4"] == Enums.LevelState.DISABLED):
		Globals.player.cleared_levels["level_4"] = Enums.LevelState.ENABLED	
	Repository.save_game()
