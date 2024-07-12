# ################################################################################################
# programmer: Yani
# desc: This script portion below is related to the test player movement; 
# and is attached to the testplayer root node
# usage: --
# #################################################################################################

extends CharacterBody2D

#specify speed of character
@export var speed: int = 35
@onready var animations = $AnimationPlayer

#create a function to handle input
func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed

#functions to update animations
func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing(): #keep this if statement because the debugger keeps checking w/o this
			animations.stop() #don't play any walk animation if player is not moving
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left" 
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up" 
	
		animations.play("walk" + direction) #calls the right animation depending on direction

# called before each physics step
func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	

#trying out dialogue

#link to the shape we made before in Actionable Node
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"): #whatever is the keybound for ui accept triggers this
		#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/sample.dialogue"), "start" ) 
		# start is the title in the dialogue script file from sample.dialogue
		
		#this looks for overlapping areas with the actionable node from test_player and npcs who have actionable
		#to debug or see in action go to debug > and tick visible collision shapes
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0]._action()
			return
		#return

