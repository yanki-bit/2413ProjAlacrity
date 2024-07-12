# ################################################################################################
# programmer: Yani
# desc: This script portion below is related to the custom DialogueManager  
# 
# usage: For testing Layout of the Modified Balloon
# ################################################################################################


#this is important, to override the default balloon
extends BaseDialogueTestScene

# make an instance of the custom balloon
func _ready() -> void:
	#put in the path to custom balloon
	var balloon = load("res://dialogue/customBalloon/balloon.tscn").instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(resource, title) #allows it to start from the resource provided at the specified title

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
