extends PathFollow2D
class_name Enemy

signal hit_player(damage: int, element: Enums.Elements)
signal die


var speed: float
var current_speed: float;
var previous_position: Vector2 = Vector2()
var element: Enums.Elements
var textures
var damage: int = 1
var maxHealth: int = 10

@onready var healthBar: ProgressBar = $HeathBar
@onready var death_timer:Timer = $DeathTimer
@onready var slow_timer:Timer = $SlowTimer
@onready var damage_origin = $DamageOrigin

var droped_gold: int = 25

var elemental_weakness = {
	Enums.Elements.FIRE: Enums.Elements.EARTH,
	Enums.Elements.WATER: Enums.Elements.FIRE,
	Enums.Elements.EARTH: Enums.Elements.NEUTRAL,
	Enums.Elements.WIND: Enums.Elements.WATER,
	Enums.Elements.NEUTRAL: Enums.Elements.WIND
}

var elemental_strength = {
	Enums.Elements.FIRE: Enums.Elements.WATER,
	Enums.Elements.WATER: Enums.Elements.WIND,
	Enums.Elements.EARTH: Enums.Elements.FIRE,
	Enums.Elements.WIND: Enums.Elements.NEUTRAL,
	Enums.Elements.NEUTRAL: Enums.Elements.EARTH
}

func _ready():
	current_speed = speed
	healthBar.max_value = maxHealth
	healthBar.value = maxHealth
	previous_position = global_position
	$Sprite2D.texture = textures[element]

func _process(delta):	
	progress_ratio += delta * 0.1 * current_speed
	
	if(progress_ratio == 1.0):
		_hit_player()
	
	var current_position =  $Sprite2D.global_position
	var diretion = (previous_position - current_position).normalized().round()
	previous_position = current_position
	
	match diretion:
		Vector2(0,1):
			$AnimationPlayer.play("walk_up")
		Vector2(0,-1):
			$AnimationPlayer.play("walk_down")
		Vector2(1,0):
			$AnimationPlayer.play("walk_left")
		Vector2(-1,0):
			$AnimationPlayer.play("walk_right")

func _hit_player():
	hit_player.emit(damage, element)
	Globals.player.current_health -= damage
	queue_free()
	
func take_damage(tower_damage:int, _tower_element:Enums.Elements):
	if(_tower_element == element):
		damage_origin.display_damage(0, Enums.AttackType.WEAK)
		return
	if(_tower_element == Enums.Elements.WATER):
		current_speed = speed * 0.4
		slow_timer.start()
	var damage_taken = _calcDamage(tower_damage, _tower_element)	
	healthBar.value -= damage_taken
	if(healthBar.value == 0):
		Globals.player.gold += droped_gold
		death_timer.wait_time = 0.1
		death_timer.start()
		die.emit()
		await death_timer.timeout
		queue_free()
		
func _on_slow_timer_timeout():
	current_speed = speed

func _calcDamage(tower_damage, _tower_element) -> int:
	if(elemental_weakness[_tower_element] == element):
		var damage_take = tower_damage/2
		damage_origin.display_damage(damage_take, Enums.AttackType.WEAK)
		return damage_take
	if(elemental_strength[_tower_element] == element):
		var damage_take = tower_damage * 2
		damage_origin.display_damage(damage_take, Enums.AttackType.STRONG)
		return damage_take
	else:
		damage_origin.display_damage(damage, Enums.AttackType.NORMAL)
		return damage
