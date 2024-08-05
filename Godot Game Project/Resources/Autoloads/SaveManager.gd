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
	load_player_data() #should load current game state and stats

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


## SINGLE SAVE FUNCTIONS
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)

var player = preload("res://Scripts/player.gd").new()

#load and save
func load_player_data():
	player.load_data()
	load_settings_data() 
	print("Successfully called the load data function")
	print(PlayerInfo)
	print(PlayerData)
	
func singleSave():
	#var player = preload("res://Scripts/player.gd").new()
	PlayerInfo.add_game_day() #adds to day 1
	print("Calling the function from player script for saving...")
	player.save()
	print("Saved the game!")
	print(playerData)

	
