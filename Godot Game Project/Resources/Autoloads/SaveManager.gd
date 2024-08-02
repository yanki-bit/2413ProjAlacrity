extends Node
#Handles save data
#path and name of the save file
const SETTINGS_SAVE_PATH : String = "user://SettingsData.save"

var settings_data_dict : Dictionary = {}

## SINGLE SAVE 
var save_file_path = "res://Scripts/save/"
var save_file_name = "DemoPlayerSave.tres"
var playerData = PlayerData.new() #you can now access variables from this script
#above is linked to file in Resources 


func _ready():
	SettingsSignalBus.set_settings_dictionary.connect(on_settings_save)
	load_settings_data()
	
	#checks file path
	verify_save_directory(save_file_path)


#saves the settings data
func on_settings_save(data : Dictionary) -> void:
	var save_settings_data_file = FileAccess.open(SETTINGS_SAVE_PATH, FileAccess.WRITE)
	var json_data_string = JSON.stringify(data)
	save_settings_data_file.store_line(json_data_string)
	
#loads settings data. Checks if it exists first
func load_settings_data() -> void:
	if not FileAccess.file_exists(SETTINGS_SAVE_PATH):
		return
	
	var save_settings_data_file = FileAccess.open(SETTINGS_SAVE_PATH, FileAccess.READ)
	var load_data : Dictionary = {}
	while save_settings_data_file.get_position() < save_settings_data_file.get_length():
		var json_string = save_settings_data_file.get_line()
		var json = JSON.new()
		var _parsed_result = json.parse(json_string)
		
		load_data = json.get_data()
	SettingsSignalBus.emit_load_settings_data(load_data)
	load_data = {}


## single save var
@export var player = preload("res://Scripts/player.gd").new()

## SINGLE SAVE FUNCTIONS
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)

#load and save
func load_data():
	#playerData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	#print("Loaded the latest saved data!")
	var player = preload("res://Scripts/player.gd").new()
	player.save()
func singleSave():
	playerData.day += 1; #add a day when saving
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	print("Saved the game!")
	print(playerData)
	# note current code always overwrites the current save file :/
