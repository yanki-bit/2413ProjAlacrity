extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Pause Player movement on contact to set animation to idle
func _on_contact():
	$Player.set_physics_process(false)

