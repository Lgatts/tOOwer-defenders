class_name WavesController

var _waves
var _wave_counter = 0
var currentWave: Wave
var totalWaves:int


func _init(waves):
	self._waves = waves
	Globals.total_waves = self._waves.size()
	Globals.current_wave = 0
	self.totalWaves = self._waves.size()
	currentWave = waves[_wave_counter]

func get_next_enemy() -> PathFollow2D:
	if(currentWave.hasEnemies()):
		return currentWave.get_enemy_instance()
	else:
		_wave_counter += 1
		return null

func set_next_wave():
	currentWave = self._waves[_wave_counter]
	
func has_more_waves() -> bool:
	return _wave_counter < totalWaves
