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

