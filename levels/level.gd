extends Node2D
class_name Level

var skeleton: PackedScene = preload("res://enemies/skeleton/skeleton.tscn")
var bat: PackedScene = preload("res://enemies/bat/bat.tscn")
var golem: PackedScene = preload("res://enemies/Golem/golem.tscn")

var _waves_controller: WavesController
var end_level: bool = true
@onready var path_pool = $PathPool
@onready var level_music = $LevelMusic
@onready var spawn_timer: Timer = $SpawnTimer
@onready var chat = $Chat
@onready var ui = $UI

signal wave_finished

func _on_complete_level():
	assert(false, "_on_complete_level not implemented")

func _ready():
	Globals.player.reset_health()
	Globals.player.reset_gold()	

func _process(_delta):
	if(Globals.player.current_health <= 0):
		TransitionScene.change_scene("res://levels/game_over.tscn")
	if(!self._waves_controller.has_more_waves() and no_enemies_left() and end_level and Globals.player.current_health > 0):
		_on_complete_level()
		TransitionScene.change_scene("res://levels/level_complete.tscn")
		end_level = false

func _on_spawn_timer_timeout():		
	var enemy = self._waves_controller.get_next_enemy()	
	var path_2d = path_pool.get_child(0)
	if(enemy != null):
			path_2d.add_child(enemy)
	else:
		spawn_timer.stop()
		if(self._waves_controller.has_more_waves()):
			self._waves_controller.set_next_wave()
			wave_finished.emit()

func _on_ui_wave_button_clicked():
	Globals.current_wave += 1
	spawn_timer.start()
	
func no_enemies_left():
	var had_enemies_left = true
	for path in path_pool.get_children():
		if(path.get_children().size() > 0):
			had_enemies_left = false
	return 	had_enemies_left


func _on_level_music_finished():
	level_music.play()

func _on_chat_dialog_finished():
	ui.wave_button.disabled = false
	level_music.play_level_music()
