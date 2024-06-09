extends Node2D

@onready var computer = $Computer
@onready var path_pool = $PathPool
@onready var spawn_timer = $SpawnTimer
@onready var ui = $UI

var enemies = [
	preload("res://enemies/skeleton/skeleton.tscn"),
	preload("res://enemies/bat/bat.tscn"),
	preload("res://enemies/Golem/golem.tscn"),
]

var rng: RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	Globals.player.reset_health()
	Globals.player.reset_gold()
	ui.enemies_counter.get_node("Label_Total").text = ""
	ui.enemies_counter.get_node("Label_Current").text = ""
	ui.enemies_counter.get_node("Label").text = "∞"
	
func _on_complete_level():
	Globals.player.cleared_levels["level_5"] = Enums.LevelState.CLEARED
	Repository.save_game()
	
func _process(_delta):
	if(Globals.player.current_health <= 0):
		TransitionScene.change_scene("res://levels/game_over.tscn")
	if(computer == null):
		_on_complete_level()
		TransitionScene.change_scene("res://levels/level_complete.tscn")

func _on_spawn_timer_timeout():
	spawn_timer.wait_time = rng.randf_range(0.1, 1.5)
	var index = rng.randi_range(0, path_pool.get_children().size() - 1)
	var element = rng.randi_range(0, 4)
	var enemy_type = rng.randi_range(0, enemies.size()-1)
	var enemy_instance = enemies[enemy_type].instantiate()
	enemy_instance.element = element
	enemy_instance.connect("die", _on_enemy_die)
	var path_2d = path_pool.get_child(index)
	path_2d.add_child(enemy_instance)
	
func _on_ui_wave_button_clicked():	
	spawn_timer.start()

func _on_enemy_die():
	computer.take_damage(1, 0)
