extends Node2D

@onready var animation_player = $CanvasLayer/AnimationPlayer

func _ready():
	animation_player.play("title")

func _on_new_game_button_pressed():
	TransitionScene.change_scene("res://screens/create_char.tscn")
