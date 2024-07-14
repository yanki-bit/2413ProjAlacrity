extends Node
#This Script is the settings manager

@onready var DEFAULT_SETTINGS : DefaultSettings = preload("res://Scenes/Resources/Settings/DefaultSettings.tres")

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
		"move_left": InputMap.action_get_events("move_left"),
		"move_right": InputMap.action_get_events("move_right"),
		"move_up": InputMap.action_get_events("move_up"),
		"move_down": InputMap.action_get_events("move_down"),
		"interact": InputMap.action_get_events("interact")
	}
	
	return settings_container_dict
	
#If no data dictionary is present provide default values
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

# Called when the node enters the scene tree for the first time.
func _ready():
	handle_signals()
	create_dictionary_store()

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
	
func handle_signals() -> void:
	SettingsSignalBus.on_window_mode_selected.connect(on_window_mode_selected)
	SettingsSignalBus.on_resolution_selected.connect(on_resolution_selected)
	SettingsSignalBus.on_master_sound_set.connect(on_master_sound_set)
	SettingsSignalBus.on_music_sound_set.connect(on_music_sound_set)
	SettingsSignalBus.on_sfx_sound_set.connect(on_sfx_sound_set)
	SettingsSignalBus.load_settings_data.connect(on_settings_data_load)


func on_settings_data_load(data : Dictionary) -> void:
	load_data = data
	on_window_mode_selected(load_data.window_mode_index)
	on_resolution_selected(load_data.resolution_index)
	on_master_sound_set(load_data.master_vol)
	on_music_sound_set(load_data.music_vol)
	on_sfx_sound_set(load_data.sfx_vol)
