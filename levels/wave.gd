class_name Wave

var _enemy_count: int
var _enemy: PackedScene
var _element: Enums.Elements
var has_enemies = true

func _init(enemy_count: int, enemy: PackedScene, element: Enums.Elements):
	self._enemy_count = enemy_count
	self._enemy = enemy
	self._element = element
	
func get_enemy_instance() -> PathFollow2D:	
	var enemy_instance = self._enemy.instantiate()
	enemy_instance.element = self._element
	self._enemy_count -= 1
	
	if(self._enemy_count == 0):
		has_enemies = false
	
	return enemy_instance
	
func hasEnemies() -> bool:
	return self.has_enemies
