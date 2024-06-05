extends CanvasLayer

@onready var animation_player = $AnimationPlayer
@onready var color_rect = $ColorRect

func _ready():
	color_rect.modulate = Color(0, 0, 0, 0)

func change_scene(scene: String):
	animation_player.clear_queue()
	animation_player.play("fade_in")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene)
	animation_player.play("fade_out")
	
