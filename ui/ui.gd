extends CanvasLayer

signal wave_button_clicked

var tower_slot_scene: PackedScene = preload("res://ui/tower_slot.tscn")

@onready var player_health_bar: ProgressBar = $PlayerHealthBar
@onready var player_texture = $PlayerTexture
@onready var player_name = $PlayerName
@onready var gold = $HBoxContainer/Gold
@onready var tower_menu = $TowerMenu
@onready var instantiate_button = %InstantiateButton
@onready var enemies_counter = %Enemies_Counter

var selectedTower: Tower

var current_tower_instance

var towers: Array[Tower]

func _ready():
	loadPlayer()
	createTowerSlots()
	tower_menu.visible = false
	Globals.connect("enemies_change", update_enemies_counter)
	Globals.player.connect("player_health_change", update_player_health_bar)
	Globals.player.connect("player_gold_change", update_player_gold)
	player_health_bar.max_value = Globals.player.max_health
	update_enemies_counter()
	update_player_health_bar()
	update_player_gold()
	connect_all_tower_slots()
	Globals.ui_state = Enums.States.DEFAULT

func loadPlayer():
	player_name.text = Globals.player.name_text
	player_texture.texture = Globals.player.texture
	if(Globals.player.textureId == 1):
		player_texture.flip_h = true

func createTowerSlots():
	for tower in Globals.player.inventory:
		var tower_slot_instance: TowerSlot = tower_slot_scene.instantiate()
		tower_slot_instance.construct(tower)
		$PanelContainer/TowersContainer.add_child(tower_slot_instance)

func update_enemies_counter():
	%Enemies_Counter/Label_Current.text = str(Globals.current_wave)
	%Enemies_Counter/Label_Total.text = str(Globals.total_waves)

func _on_button_pressed():
	wave_button_clicked.emit()
	%WaveButton.disabled = true

func _on_level_1_wave_finished():
	%WaveButton.disabled = false
	
func _on_exit_button_pressed():
	Repository.load_game()
	TransitionScene.change_scene("res://levels/over_world.tscn")

func update_player_health_bar():
	player_health_bar.value = Globals.player.current_health
	
func update_player_gold():
	gold.text = str(Globals.player.gold)

func connect_all_tower_slots():
	for tower_slot_instance in $PanelContainer/TowersContainer.get_children():
		tower_slot_instance.connect("select_tower", _on_tower_slot_select_tower)

func _on_tower_slot_select_tower(tower, slot_global_position):
	_delete_currente_tower_instance()
	selectedTower = tower	
	tower_menu.global_position = Vector2(slot_global_position.x - 300, slot_global_position.y)
	tower_menu.visible = true
	instantiate_button.disabled = (Globals.player.gold < selectedTower._cost)

func _on_instantiate_button_pressed():
	_delete_currente_tower_instance()
	tower_menu.visible = false
	current_tower_instance = selectedTower.instantiate()
	current_tower_instance.global_position = get_viewport().get_mouse_position()
	get_parent().get_node("Towers").add_child(current_tower_instance)
	Globals.ui_state = Enums.States.INSTANTIATING

func _on_inheritance_button_pressed():
	$InheritancePanel.global_position.x = $TowerMenu/InheritanceButton.global_position.x - 500
	$InheritancePanel.create(selectedTower)
	tower_menu.visible = false
	
func _physics_process(_delta):
	if(Globals.ui_state == Enums.States.INSTANTIATING):
		current_tower_instance.global_position = get_viewport().get_mouse_position()
		
func _unhandled_input(event):
	if(Globals.ui_state == Enums.States.INSTANTIATING and _isLeftClickMouse(event) and current_tower_instance.can_be_placed):
			current_tower_instance.place()
			current_tower_instance = null
			Globals.ui_state = Enums.States.DEFAULT
	if(Globals.ui_state == Enums.States.INSTANTIATING and _isRightClickMouse(event)):
		_delete_currente_tower_instance()
		Globals.ui_state = Enums.States.DEFAULT
	if(tower_menu.visible and _isLeftClickMouse(event)):
		tower_menu.visible = false
		_delete_currente_tower_instance()
			
func _isLeftClickMouse(event):
	return event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT
	
func _isRightClickMouse(event):
	return event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT

func _delete_currente_tower_instance():
	if(current_tower_instance != null):
		current_tower_instance.queue_free()
		Globals.ui_state = Enums.States.DEFAULT	
