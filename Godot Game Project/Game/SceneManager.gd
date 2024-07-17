extends Node2D

var next_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	transition_to_first_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Load first scene after pressing start in main menu
func transition_to_first_scene():
	$CurrentScene.add_child(load("res://Scenes/room.tscn").instantiate())
	
	# Fade from black to screen
	await get_tree().create_timer(0.5).timeout
	$"ScreenTransition/AnimationPlayer".play("Fade_To_Screen")
	
# transition to the next scene by recieving location of next scene in file
func _transition_to_next_scene(new_scene: String):
	$"ScreenTransition/AnimationPlayer".play("Fade_To_Black")
	next_scene = new_scene
	
# finish transition by removing old scene and placing new scene into current scene
# automatically runs this function at the end of fade to black animation
func finish_transition_to_next_scene():
	$CurrentScene.get_child(0).queue_free()
	$CurrentScene.add_child(load(next_scene).instantiate())
	$"ScreenTransition/AnimationPlayer".play("Fade_To_Screen")
func transition_to_combat():
	pass
