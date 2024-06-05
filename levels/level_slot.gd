extends MarginContainer

@onready var texture_rect = $TextureRect
@onready var padlock = $Padlock
@onready var cleared = $Cleared
@export var texture: Texture2D
@export var level_path: Resource
var _level_state: Enums.LevelState = Enums.LevelState.DISABLED
var _grey_shader = load("res://shaders/grey_shader.tres")

func _ready():
	texture_rect.texture = texture
	_pad_lock_visibility()
	_cleared_visibility()
	_update_level_color()

func _on_texture_rect_gui_input(event):
	if(Globals._isLeftClickMouse(event) and !_is_level_disabled()):
		TransitionScene.change_scene(level_path.resource_path)

func _pad_lock_visibility():	
	padlock.visible = _is_level_disabled()
	
func _cleared_visibility():	
	cleared.visible = _is_level_cleared()

func _is_level_disabled() -> bool:
	return _level_state == Enums.LevelState.DISABLED
	
func _is_level_cleared() -> bool:
	return _level_state == Enums.LevelState.CLEARED

func _update_level_color():
	if(_is_level_disabled()):
		texture_rect.material = _grey_shader
	else:
		texture_rect.material = null
		texture_rect.modulate = Color(0.300, 0.300, 0.300)

func change_level_state(new_state: Enums.LevelState):
	_level_state = new_state
	_update_level_color()
	_pad_lock_visibility()
	_cleared_visibility()

func _on_texture_rect_mouse_entered():
	texture_rect.modulate = Color(1,1,1)

func _on_texture_rect_mouse_exited():
	texture_rect.modulate = Color(0.204, 0.204, 0.204)
