extends Control

## BUTTON VARIABLES
@onready var save_1 = %slot_1
@onready var save_2 = %slot_2
@onready var save_3 = %slot_3

#notifies player if they can save or load a game
#var load_save_label

var save_game = "res://Resources/Autoloads/saveGlobal.gd"

## updated_save
func updated_save(): #updates if save exists 
	print(save_game.save_dates)
	save_1.text = SaveGlobal.save_dates
	save_2.text = SaveGlobal.save_dates
	save_3.text = SaveGlobal.save_dates
			#'3': save_0.text = saveGlobal.save_dates[key]


########################
# Button functions 

func _on_auto_slot_pressed():
	if %auto_slot.text == "Empty Save": #saves
		SaveGlobal.emit_signal('save_game_main', 'auto')
	else: #loads
		SaveGlobal.emit_signal('load_game_main', 'auto')

func _on_slot_1_pressed():
	if save_1.text == "Slot 1": #saves
		SaveGlobal.emit_signal('save_game_main', '1')
		%slot_1Label.text = SaveGlobal.save_dates
	else: #loads
		SaveGlobal.emit_signal('load_game_main', '1')


