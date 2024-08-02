extends Node
#Handles save data
#path and name of the save file
const SETTINGS_SAVE_PATH : String = "user://SettingsData.save"

var settings_data_dict : Dictionary = {}

func _ready():
	SettingsSignalBus.set_settings_dictionary.connect(on_settings_save)
	load_settings_data()
	
	# connect signals from saveGlobal script
	SaveGlobal.load_game_main.connect(load_game_main)
	SaveGlobal.save_game_main.connect(save_game_main)
	create_or_load_save()

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

# for saving Player stuff
# referencing save resource in save folder
var save: SaveGame

## MULTI SAVES ##

func create_or_load_save():
	if SaveGame.save_exists('auto'):
		load_game_main('auto')
	else:
		save_game_main('auto')

func save_game_main(id: String):
	
	#create a new SaveGame resource
	save = SaveGame.new()
	
	#reference the stuff we need to save
	#save.player_position = PlayerInfo.globalposition
	save.player_name = PlayerInfo.player_name
	
	
	#saves
	save.write_savegame(id)
	print("Saved game")
	
	#globs.emit_signal('updated_save')

func load_game_main(id: String):
	
	#check if the save does not exist
	if SaveGlobal.save_exists(id) == false: return
	
	#load save
	save = SaveGlobal.load_savegame(id) as SaveGame
	
	#these are the stuff to load
	PlayerInfo.globalposition = save.player_position
	
## SAVES END ##
