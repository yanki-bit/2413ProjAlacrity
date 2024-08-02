extends Node


## save and load signals
# connects to the SaveManager.gd script and SaveGame.gd
signal load_game_main
signal save_game_main
signal updated_save

# Called when the node enters the scene tree for the first time.
func _ready():
	#verify_save_dir()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

######################################
## Save and Loading Functions ##

#var save_file_path
