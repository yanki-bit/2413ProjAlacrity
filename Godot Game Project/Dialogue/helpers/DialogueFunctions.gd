extends Node
const BALLOON = preload("res://Dialogue/balloon.tscn")
var dialogue_resource
signal sceneOne
signal sceneTwo
signal dialogue_finished
#function to play default dialogue box
func playDefaultDialogue(title : String):
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, title)
	emit_signal("dialogue_finished")
	
func dialoguefinished():
	emit_signal("dialogue_finished")
	
#function to custom dialogue box
func playDialogue(title: String):
	var balloon: Node = BALLOON.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, title)
	emit_signal("dialogue_finished")

var player_node: Node = null

func set_player_node(node: Node):
	player_node = node

func stop_player_physics():
	if player_node:
		player_node.set_physics_process(false)
		
func start_player_physics():
	if player_node:
		if player_node.is_physics_processing():
			pass
		else:
			player_node.set_physics_process(true)
		
func scene_one():
	emit_signal("sceneOne")
	
func scene_two():
	emit_signal("sceneTwo")


#function to rename player character
func rename_file(old_path: String, new_path: String) -> bool:
	var file = FileAccess.open(old_path, FileAccess.ModeFlags.READ)
	#check if the old file exists
	if file == null:
		return false
	#check if the new file exists
	file = FileAccess.open(new_path, FileAccess.ModeFlags.READ)
	if file:
		return false
		
# Create a directory instance to rename the file
	var dir = DirAccess.open("res://")
	var error = dir.rename(old_path,new_path)
	if error == OK:
		return true
	else:
		return false
