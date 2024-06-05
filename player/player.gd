class_name Player

signal player_health_change
signal player_gold_change

var inventory: Array[Tower]
var max_health: int
var name_text: String
var texture: Texture2D
var textureId: int
var cleared_levels: Dictionary

var current_health: int:
	set(value):
		current_health = value
		player_health_change.emit()
		
var gold: int:
	set(value):
		gold = value
		player_gold_change.emit()
		
func _init():
	gold = 200
	max_health = 10
	current_health = 10
	
	cleared_levels = {
		"level_1": Enums.LevelState.ENABLED,
		"level_2": Enums.LevelState.DISABLED,
		"level_3": Enums.LevelState.DISABLED,
		"level_4": Enums.LevelState.DISABLED,
		"level_5": Enums.LevelState.DISABLED,
	}
	
	inventory.append(Tower.new(Enums.Elements.NEUTRAL))
#Para testes
	#inventory.append(Tower.new(Enums.Elements.WATER))
	#inventory.append(Tower.new(Enums.Elements.FIRE))
	#inventory.append(Tower.new(Enums.Elements.EARTH))
	#inventory.append(Tower.new(Enums.Elements.WIND))

func reset_health():
	current_health = max_health
	
func reset_gold():
	if gold < 200:
		gold = 10000	
