# ################################################################################################
# programmer: Yani
# desc: This script portion below is related to the Actionable node and the test_player node; 
# and is attached to the Actionable node
# usage:
# 1. Make sure your Actionable's Collision layer (under Collision Object 2D) is set to Layer 5
# 2. Don't forget to activate it
# 3. Attach this to any npc character
# #################################################################################################


extends Area2D


@export var dialogue_resource: DialogueResource #one export to attach the dialogue file
@export var dialogue_Start: String = "start" #this var specifies from which title are we starting from

# shows the actionable, can be attached
func _action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_Start)

