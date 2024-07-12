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
	
# transition to the next scene by recieving location of next scene in file
# deletes the current scene then adds the new scene as a child of "current scene"
func transition_to_next_scene(new_scene: String):
	next_scene = new_scene
	$CurrentScene.get_child(0).queue_free()
	$CurrentScene.add_child(load(next_scene).instantiate())
