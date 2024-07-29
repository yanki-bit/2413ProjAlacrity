class_name Rooms extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Pause Player movement on contact to set animation to idle
func _on_contact():
	$Player.set_physics_process(false)
	

func unpause_player_movement():
	$Player.set_physics_process(true)
	
	
#pause other things while the inventory is open
# set the canvas layer node's  mode to always
func _on_inventory_gui_opened():
	get_tree().paused = true
	

func _on_inventory_gui_closed():
	get_tree().paused = false

