extends CharacterBody2D

#export allows us to adjust variables on game engine
@export var move_speed : float = 100
@export var start_dir : Vector2 = Vector2(0,1)

#Finds the node called animation tree and stores it in variable
@onready var anim_tree = $AnimationTree
#Changes State/Blendspace
@onready var state = anim_tree.get("parameters/playback")



#Setup as the script runs
func _ready():
	anim_tree.set("parameters/Idle/blend_position",start_dir)
	update_animation_parameter(start_dir)
	
func _physics_process(delta):
	#get input direction
	var input_dir = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	
	#updates the direction based on input
	update_animation_parameter(input_dir)
	
	#update velocity
	velocity = input_dir * move_speed
	
	new_state()	
	#move and slide function uses velocity of character to move character on map
	move_and_slide()

#Function to update the direction the character faces when input is pressed
func update_animation_parameter(move_input : Vector2):
	#No change when there is no input
	if (move_input != Vector2.ZERO):
		anim_tree.set("parameters/Walk/blend_position", move_input)
		anim_tree.set("parameters/Idle/blend_position", move_input)

#Choose state based on player action
func new_state():
	if(velocity != Vector2.ZERO):
		state.travel("Walk")
	else:
		state.travel("Idle")
