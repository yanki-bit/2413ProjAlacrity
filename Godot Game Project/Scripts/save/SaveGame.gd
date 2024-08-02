extends Resource
class_name SaveGame # so anything here can be referenced later

# save path
const SAVE_GAME_PATH := "res://Scripts/save/save_" #id counters get added later in the script

# variables we want to save
@export var player_position := Vector2.ZERO
@export var player_name = PlayerInfo.player_name #calls on the saved name player inputted

#counts save file number
@export var version := 1 

## FUNCTIONS
# save the game
func write_savegame(id: String) -> void:
	var save_path = str(SAVE_GAME_PATH + id + '.tres')
	ResourceSaver.save(self, save_path)

#check if a save exists
static func save_exists(id: String) -> bool:
	var save_path = str(SAVE_GAME_PATH + id + '.tres')
	return ResourceSaver.exists(save_path)

#load save
static func load_savegame(id: String) -> Resource:
	var save_path = str(SAVE_GAME_PATH + id + '.tres')
	return ResourceSaver.load(save_path, "", 2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
