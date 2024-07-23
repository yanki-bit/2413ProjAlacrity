extends Node
#This Script is the settings manager

@onready var DEFAULT_SETTINGS : DefaultSettings = preload("res://Scenes/Resources/Settings/DefaultSettings.tres")
@onready var keybind_resource : PlayerKeybindResource = preload("res://Scenes/Resources/Settings/PlayerKeybindDefaults.tres")
var window_mode_index: int = 0
var resolution_index: int = 0
var master_vol: float = 0.0
var music_vol: float = 0.0
var sfx_vol: float = 0.0

var load_data : Dictionary = {}

func create_dictionary_store() -> Dictionary:
	var settings_container_dict: Dictionary = {
		"window_mode_index": window_mode_index,
		"resolution_index": resolution_index,
		"master_vol": master_vol,
		"music_vol": music_vol,
		"sfx_vol": sfx_vol,
		"keybinds": create_keybind_dict()
	}
	return settings_container_dict
	
#customized keys
func create_keybind_dict() -> Dictionary:
	var keybinds_container_dict = {
		keybind_resource.MOVE_LEFT : keybind_resource.move_left_key,
		keybind_resource.MOVE_RIGHT : keybind_resource.move_right_key,
		keybind_resource.MOVE_UP : keybind_resource.move_up_key,
		keybind_resource.MOVE_DOWN : keybind_resource.move_down_key,
		keybind_resource.INTERACT : keybind_resource.interact_key
	}
	return keybinds_container_dict
	
#If no data dictionary is present provide default values GETTERS
func get_window_index() -> int:
	if load_data == {}:
		return DEFAULT_SETTINGS.WINDOW_INDEX
	return window_mode_index
func get_resolution_index() -> int:
	if load_data == {}:
		return DEFAULT_SETTINGS.RESOLUTION_INDEX
	return resolution_index
func get_master_vol() -> float:
	if load_data == {}:
		return DEFAULT_SETTINGS.MASTER_VOL
	return master_vol
func get_music_vol() -> float:
	if load_data == {}:
		return DEFAULT_SETTINGS.MUSIC_VOL
	return music_vol
func get_sfx_vol() -> float:
	if load_data == {}:
		return DEFAULT_SETTINGS.SFX_VOL
	return sfx_vol

func get_keybind(action : String):
	if !load_data.has("keybinds"):
		match action:
			keybind_resource.MOVE_LEFT:
				return keybind_resource.DEFAULT_MOVE_LEFT_KEY
			keybind_resource.MOVE_RIGHT:
				return keybind_resource.DEFAULT_MOVE_RIGHT_KEY
			keybind_resource.MOVE_UP:
				return keybind_resource.DEFAULT_MOVE_UP_KEY
			keybind_resource.MOVE_DOWN:
				return keybind_resource.DEFAULT_MOVE_DOWN_KEY
			keybind_resource.INTERACT:
				return keybind_resource.DEFAULT_INTERACT_KEY
	else:
		match action:
			keybind_resource.MOVE_LEFT:
				return keybind_resource.move_left_key
			keybind_resource.MOVE_RIGHT:
				return keybind_resource.move_right_key
			keybind_resource.MOVE_UP:
				return keybind_resource.move_up_key
			keybind_resource.MOVE_DOWN:
				return keybind_resource.move_down_key
			keybind_resource.INTERACT:
				return keybind_resource.interact_key
				
# Called when the node enters the scene tree for the first time.
func _ready():
	handle_signals()
	create_dictionary_store()
	
# SETTERS
func on_window_mode_selected(index : int) -> void:
	window_mode_index = index
func on_resolution_selected(index : int) -> void:
	resolution_index = index
func on_master_sound_set(value : float) -> void:
	master_vol = value
func on_music_sound_set(value : float) -> void:
	music_vol = value
func on_sfx_sound_set(value : float) -> void:
	sfx_vol = value
	
func set_keybind(action : String, event) -> void:
	match action:
		keybind_resource.MOVE_LEFT:
			keybind_resource.move_left_key = event
		keybind_resource.MOVE_RIGHT:
			keybind_resource.move_right_key = event
		keybind_resource.MOVE_UP:
			keybind_resource.move_up_key = event
		keybind_resource.MOVE_DOWN:
			keybind_resource.move_down_key = event
		keybind_resource.INTERACT:
			keybind_resource.interact_key = event
			
func handle_signals() -> void:
	SettingsSignalBus.on_window_mode_selected.connect(on_window_mode_selected)
	SettingsSignalBus.on_resolution_selected.connect(on_resolution_selected)
	SettingsSignalBus.on_master_sound_set.connect(on_master_sound_set)
	SettingsSignalBus.on_music_sound_set.connect(on_music_sound_set)
	SettingsSignalBus.on_sfx_sound_set.connect(on_sfx_sound_set)
	#loads settings data from save manager script
	#then connects to the on settings data load function to set the settings 
	SettingsSignalBus.load_settings_data.connect(on_settings_data_load)

func on_keybinds_loaded(data : Dictionary) -> void:
	var load_move_left = InputEventKey.new()
	var load_move_right = InputEventKey.new()
	var load_move_up = InputEventKey.new()
	var load_move_down = InputEventKey.new()
	var load_interact = InputEventKey.new()

	#note that its looking for the action name
	load_move_left.set_physical_keycode(int(data.move_left))
	load_move_right.set_physical_keycode(int(data.move_right))
	load_move_up.set_physical_keycode(int(data.move_up))
	load_move_down.set_physical_keycode(int(data.move_down))
	load_interact.set_physical_keycode(int(data.interact))
	
	keybind_resource.move_left_key = load_move_left
	keybind_resource.move_right_key = load_move_right
	keybind_resource.move_up_key = load_move_up
	keybind_resource.move_down_key = load_move_down
	keybind_resource.interact_key = load_interact
	

func on_settings_data_load(data : Dictionary) -> void:
	load_data = data
	on_window_mode_selected(load_data.window_mode_index)
	on_resolution_selected(load_data.resolution_index)
	on_master_sound_set(load_data.master_vol)
	on_music_sound_set(load_data.music_vol)
	on_sfx_sound_set(load_data.sfx_vol)
	on_keybinds_loaded(load_data.keybinds)
