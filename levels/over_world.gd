extends Node2D

@onready var level_1 = $CanvasLayer/HBoxContainer/Level1
@onready var level_2 = $CanvasLayer/HBoxContainer/Level2
@onready var level_3 = $CanvasLayer/HBoxContainer/Level3
@onready var level_4 = $CanvasLayer/HBoxContainer2/Level4
@onready var level_5 = $CanvasLayer/HBoxContainer2/Level5

func _ready():
	level_1.change_level_state(Globals.player.cleared_levels["level_1"])
	level_2.change_level_state(Globals.player.cleared_levels["level_2"])
	level_3.change_level_state(Globals.player.cleared_levels["level_3"])
	level_4.change_level_state(Globals.player.cleared_levels["level_4"])
	level_5.change_level_state(Globals.player.cleared_levels["level_5"])

func _on_exit_button_pressed():
	TransitionScene.change_scene("res://game.tscn")
