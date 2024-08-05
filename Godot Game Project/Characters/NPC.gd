class_name NonPlayerCharacter
extends CharacterBody2D
@onready var anim_tree = $AnimationTree
@onready var state = anim_tree.get("parameters/playback")

@export var movement_target : Node2D
@export var nav_agent: NavigationAgent2D
@export var move_speed : float = 200

func _ready():
	$".".set_physics_process(false)
	$Actionable.connect("interacted", Callable(self, "next_dialogue"))

	
func next_dialogue():
	$Actionable.dialogue_start = "Luke2"
func start_movement():
	$".".set_physics_process(true)
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0
	
	call_deferred("actor_setup")
	update_animation_parameter(movement_target.position)
	
func actor_setup():
	await get_tree().physics_frame
	set_movement_target(movement_target.position)
	
func set_movement_target(target_point: Vector2):
	nav_agent.target_position = target_point
	
func _physics_process(delta): 
	if nav_agent.is_navigation_finished():
		anim_tree.set("parameters/IDLE/blend_position", Vector2(0,-1))
		state.travel("IDLE")
	
		return
		
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav_agent.get_next_path_position()
	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * move_speed
	velocity = new_velocity
	
	update_animation_parameter(current_agent_position)
	
	new_state()
	move_and_slide()

#Function to update the direction the character faces when input is pressed
func update_animation_parameter(move_input : Vector2):
	#No change when there is no input
	if (move_input != global_position):
		anim_tree.set("parameters/WALK/blend_position", move_input)
		anim_tree.set("parameters/IDLE/blend_position", move_input)
		
#Choose state based on player action
func new_state():
	if(velocity != Vector2.ZERO):
		state.travel("WALK")
	else:
		state.travel("IDLE")
