class_name Room
extends Node2D

# Pause Player movement on contact to set animation to idle

func _on_contact():
	$Player.set_physics_process(false)
	
func unpause_player_movement():
	$Player.set_physics_process(true)
	pass
