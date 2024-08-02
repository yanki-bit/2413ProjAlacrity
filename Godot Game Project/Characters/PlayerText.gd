extends Control

#this signal is connected to the player node script signal
func _on_player_update_ui(name, day, playerPos):
	$currentName.text = "name: " + str(name)
	$currentDay.text = "day: " + str(day)
	$currentPos.text = "Player Position: " + str(playerPos)

#$currentName.text = "name: " + str(name)
#	$currentDay.text = "day: " + day
#	$currentPos.text = "Player Position: " + str(playerPos)
