extends Node2D

@onready var computer = $Computer
@onready var path_pool = $PathPool
@onready var spawn_timer = $SpawnTimer
@onready var ui = $UI
@onready var level_music = $LevelMusic
@onready var chat = $Chat

var _level_end: bool = false

var enemies = [
	preload("res://enemies/skeleton/skeleton.tscn"),
	preload("res://enemies/bat/bat.tscn"),
	preload("res://enemies/Golem/golem.tscn"),
]

var rng: RandomNumberGenerator

func _ready():
	chat.display_chat(Level5Dialog.dialogs5)
	rng = RandomNumberGenerator.new()
	rng.randomize()
	Globals.player.reset_health()
	Globals.player.reset_gold()
	ui.enemies_counter.get_node("Label_Total").text = ""
	ui.enemies_counter.get_node("Label_Current").text = ""
	ui.enemies_counter.get_node("Label").text = "∞"
	level_music.play()
	
func _on_complete_level():
	spawn_timer.stop()
	_level_end = true
	_remove_all_enemies()
	await computer.play_explosion()
	Globals.player.cleared_levels["level_5"] = Enums.LevelState.CLEARED
	Repository.save_game()
	TransitionScene.change_scene("res://levels/game_complete.tscn")

func _remove_all_enemies():
	for path in path_pool.get_children():
		for enemy in path.get_children():
			enemy.queue_free()

func _process(_delta):
	if(Globals.player.current_health <= 0):
		TransitionScene.change_scene("res://levels/game_over.tscn")

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
	if(!_level_end):
		spawn_timer.start()

func _on_enemy_die():
	if(!_level_end):
		computer.take_damage(1, 0)

func _on_computer_computer_die():
	_on_complete_level()
	
func _on_level_music_finished():
	level_music.play()

func _on_chat_dialog_finished():
	ui.wave_button.disabled = false
	level_music.play_level_music()
	
