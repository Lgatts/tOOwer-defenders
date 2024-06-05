extends PathFollow2D
class_name Enemy

signal hit_player(damage: int, element: Enums.Elements)

@export
var speed: float = 0.5
var previous_position: Vector2 = Vector2()
var element: Enums.Elements
var textures
var damage: int = 1
var maxHealth: int = 10
@onready
var healthBar: ProgressBar = $HeathBar
@onready var death_timer:Timer = $DeathTimer
var droped_gold: int = 25


func _ready():
	healthBar.max_value = maxHealth
	healthBar.value = maxHealth
	previous_position = global_position
	$Sprite2D.texture = textures[element]

func _process(delta):
	progress_ratio += delta * 0.1 * speed
	
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
	healthBar.value -= tower_damage
	if(healthBar.value == 0):
		Globals.player.gold += droped_gold
		death_timer.wait_time = 0.1
		death_timer.start()
		await death_timer.timeout
		queue_free()
