extends Area2D

@onready var healthBar: ProgressBar = $HeathBar
@onready var death_timer:Timer = $DeathTimer
var droped_gold: int = 1000
var maxHealth: int = 1000

func _ready():
	healthBar.max_value = maxHealth
	healthBar.value = maxHealth
	
func take_damage(tower_damage:int, _tower_element:Enums.Elements):
	healthBar.value -= tower_damage
	if(healthBar.value == 0):
		Globals.player.gold += droped_gold
		death_timer.wait_time = 0.1
		death_timer.start()
		await death_timer.timeout
		queue_free()
