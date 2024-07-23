extends Node
const BALLOON = preload("res://Dialogue/balloon.tscn")
var dialogue_resource
signal sceneClass
signal sceneWork
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
		player_node.set_physics_process(true)
		
func scene_class():
	emit_signal("sceneClass")
	
func scene_work():
	emit_signal("sceneWork")
