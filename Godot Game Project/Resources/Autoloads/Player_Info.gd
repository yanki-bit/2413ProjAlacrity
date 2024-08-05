extends Node
class_name player_Info

@export var player_name = "Justin"
@export var score = 0
@export var acad = 0

@export var day = 0


@export var state: Dictionary = {
	"Bedroom":
		false,
	"Classroom":
		false,
	"Library":
		false,
	"Hallway":
		false
	}

#callable function to add to game day
func add_game_day(AddDay = 1) -> void:
	day += AddDay

##########
var playersave_path := "res://Resources/Save2/player_data.json"

func saveplayer_info() -> void:
	## GG
	var data := {
	"Bedroom": 
		PlayerInfo.state["Bedroom"],
	"Classroom": 
		PlayerInfo.state["Classroom"],
	"Library":
		PlayerInfo.state["Library"],
	"Hallway":
		PlayerInfo.state["Hallway"],
	"player_name":
		PlayerInfo.player_name,
	"day":
		PlayerInfo.day,
	"bgm":
		Bgm
	}
	
	name = PlayerInfo.player_name
	day = PlayerInfo.day
	
	#references the state Dictionary
	var json = JSON.new()
	var player_json := json.stringify(data)
	
	var playerfile_access := FileAccess.open(playersave_path, FileAccess.WRITE)
	if not playerfile_access:
		print("Whoops! An error happened while saving data: ", FileAccess.get_open_error() )
		return
	#writes to save file
	playerfile_access.store_line(player_json)
	playerfile_access.close()
	
	
func loadplayer_info() -> void:
	##JSON LOAD
	if not FileAccess.file_exists(playersave_path):
		print("File currently doesn't exist...")
		return
	var file_access := FileAccess.open(playersave_path, FileAccess.READ)
	var json_string := file_access.get_line()
	file_access.close()
	
	var json := JSON.new()
	var error := json.parse(json_string)
	if error :
		print("JSON parse error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
	
	var data: Dictionary = json.data
	state["Bedroom"] = data.get("Bedroom", " ")
	state["Classroom"] = data.get("Classroom", " ")
	state["Library"] = data.get("Library", " ")
	state["Hallway"] = data.get("Hallway", " ")
	player_name = data.get("player_name")
	day = data.get("day")
	#Bgm = data.get("bgm") # cannot assign value to constant error
	
	if data == {}:
		print("The save state is empty, using defaults")
		default_player_settings()
	
	
	#trying to load music, let's see if it works...
	#did not fmlllll
	#if Bgm.playing == false:
	#	Bgm.play()
	Bgm.autoplay

func default_player_settings():
	state = {
		"Bedroom": false,
		"Classroom": false,
		"Library": false,
		"Hallway": false
	}
	
	player_name = "Justin"
	day = 0
	
	Bgm.play()
	


