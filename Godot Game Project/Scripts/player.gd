extends CharacterBody2D

@onready var player_menu = $Player_Menu
@onready var actionable_finder = $Direction/ActionableFinder

 #export allows us to adjust variables on game engine
@export var move_speed : float = 200
@export var start_dir : Vector2 = Vector2(0,1)

#Finds the node called animation tree and stores it in variable
@onready var anim_tree = $AnimationTree
#Changes State/Blendspace
@onready var state = anim_tree.get("parameters/playback")
# Preload player statsheet to have access to variables at initialization
@export var statsheet = preload("res://Characters/player_stats.tres")

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
		var actionables =  actionable_finder.get_overlapping_areas()
		if actionables.size()>0:
			actionables[0].action()
			return

# set spawn location
func set_spawn(location: Vector2, direction: Vector2):
	anim_tree.set("parameters/Idle/blend_position",direction)
	position = location

# Setters for setting stats 
func set_MAX_HP(value:int):
	statsheet.MAX_HP = value

func set_CURR_HP(value:int):
	statsheet.CURR_HP = value

func set_ATK(value:int):
	statsheet.ATK = value

func set_DEF(value:int):
	statsheet.DEF = value

func set_SPD(value:int):
	statsheet.SPD = value

func set_LCK(value:int):
	statsheet.LCK = value

func set_ENERGY(value:int):
	statsheet.ENERGY = value

# Getters for stats
func get_MAX_HP():
	return statsheet.MAX_HP

func get_CURR_HP():
	return statsheet.CURR_HP

func get_ATK():
	return statsheet.ATK

func get_DEF():
	return statsheet.DEF

func get_SPD():
	return statsheet.SPD

func get_LCK():
	return statsheet.LCK

func get_ENERGY():
	return statsheet.ENERGY

