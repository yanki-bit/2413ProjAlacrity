extends CharacterBody2D

@onready var player_menu = $Player_Menu

 #export allows us to adjust variables on game engine
@export var move_speed : float = 200
@export var start_dir : Vector2 = Vector2(0,1)

#Finds the node called animation tree and stores it in variable
@onready var anim_tree = $AnimationTree
#Changes State/Blendspace
@onready var state = anim_tree.get("parameters/playback")

#Setup as the script runs
func _ready():
	anim_tree.set("parameters/Idle/blend_position",start_dir)
	update_animation_parameter(start_dir)
	
func _physics_process(_delta):
	#get input direction
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	update_animation_parameter(input_dir)
	
	#update velocity
	velocity = input_dir * move_speed
	
	new_state()	
	#move and slide function uses velocity of character to move character on map
	move_and_slide()

func _process(_delta):
	# Switch to Idle animation if player physics is paused
	if is_physics_processing() == false:
		state.travel("Idle")
	#updates the direction based on input
	
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
		
		
# stop player movement when encountering countbook boss
func _on_count_book_boss_trigger():
	set_physics_process(false)
	
#Dialogue test
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/main.dialogue"), "start")
		return
