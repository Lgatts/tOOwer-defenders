extends Area2D

@onready var healthBar: ProgressBar = $HeathBar
@onready var death_timer:Timer = $DeathTimer
@onready var animation_player = $AnimationPlayer
@onready var explosion = $Explosion
@onready var explosion_positions = $ExplosionPositions
signal computer_die

var droped_gold: int = 1000
var maxHealth: int = 500

func _ready():
	healthBar.max_value = maxHealth
	healthBar.value = maxHealth
	
func take_damage(tower_damage:int, _tower_element:Enums.Elements):
	healthBar.value -= tower_damage
	if(healthBar.value == 0):
		Globals.player.gold += droped_gold
		computer_die.emit()

func play_explosion():
	explosion.visible = true
	for i in range(5):
		var positionMaker = explosion_positions.get_child(i)
		explosion.position = positionMaker.position
		animation_player.play("explosion")
		await animation_player.animation_finished
	queue_free()
