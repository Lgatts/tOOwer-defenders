extends Level

func _ready():
	super._ready()
	var waves = [
		#Wave.new(1, bat, Enums.Elements.NEUTRAL),
		Wave.new(2, skeleton, Enums.Elements.NEUTRAL),
		Wave.new(10, skeleton, Enums.Elements.NEUTRAL),
		#Wave.new(4, skeleton, Enums.Elements.NEUTRAL),
		#Wave.new(4, bat, Enums.Elements.NEUTRAL)
	]
	self._waves_controller = WavesController.new(waves)

func _on_complete_level():
	if(Globals.player.inventory.size() == 1):
		Globals.player.inventory.append(Tower.new(Enums.Elements.WATER))
