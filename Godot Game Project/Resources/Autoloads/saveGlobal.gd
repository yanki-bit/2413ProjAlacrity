extends Node


## save and load signals
# connects to the SaveManager.gd script and SaveGame.gd
signal load_game_main
signal save_game_main
signal updated_save
	

######################################
## Save and Loading Functions ##

## access with save_dates[id]

@onready var save_dates: Dictionary

func update_save_dates():
	var save: SaveGame
	if SaveGame.save_exists('auto'): #autosave file
		save = SaveGame.load_savegame('auto') as SaveGame
		#make sure to reference what to reflect from savegame resource
		save_dates['auto'] = save.player_name 
	
	if SaveGame.save_exists('0'):
		save = SaveGame.load_savegame('0') as SaveGame
		#there was a script about dates
		save_dates['0'] = save.player_name 
	if SaveGame.save_exists('1'):
		save = SaveGame.load_savegame('0') as SaveGame
		#there was a script about dates
		save_dates['1'] = save.player_name 
	if SaveGame.save_exists('2'):
		save = SaveGame.load_savegame('2') as SaveGame
		#there was a script about dates
		save_dates['2'] = save.player_name 

