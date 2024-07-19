class_name Rooms extends Node2D
const BALLOON = preload("res://Dialogue/balloon.tscn")

@export var dialogue_resource: DialogueResource

var player_node : Node = null
# Called when the node enters the scene tree for the first time.
func _ready():
	get_player(player_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	
func get_player(node : Node):
	node = $Player
	DialogueFunctions.player_node = node
	playDialogue()
	

func playDialogue():
	var balloon: Node = BALLOON.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, "DayOne")
	DialogueFunctions.stop_player_physics()
	playNextDialogue()
	
func playNextDialogue():
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, "Monologue1")
	DialogueFunctions.start_player_physics()
# Pause Player movement on contact to set animation to idle
func _on_contact():
	$Player.set_physics_process(false)

func unpause_player_movement():
	$Player.set_physics_process(true)
	pass
