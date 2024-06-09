extends Level

func _ready():
	super._ready()
	var waves = [
		Wave.new(10, skeleton, Enums.Elements.EARTH),
		Wave.new(15, skeleton, Enums.Elements.WIND),
		Wave.new(3, bat, Enums.Elements.WIND),
		Wave.new(5, skeleton, Enums.Elements.FIRE),
		Wave.new(2, golem, Enums.Elements.WIND),
	]
	self._waves_controller = WavesController.new(waves)

func _on_complete_level():
	if(Globals.player.inventory.size() == 4):
		Globals.player.inventory.append(Tower.new(Enums.Elements.WIND))
	Globals.player.cleared_levels["level_4"] = Enums.LevelState.CLEARED
	if(Globals.player.cleared_levels["level_5"] == Enums.LevelState.DISABLED):
		Globals.player.cleared_levels["level_5"] = Enums.LevelState.ENABLED
	Globals.player.gold += 800
	Repository.save_game()
