extends CanvasLayer


func _on_continue_button_pressed():
	Repository.load_game()
	TransitionScene.change_scene("res://levels/over_world.tscn")
	
