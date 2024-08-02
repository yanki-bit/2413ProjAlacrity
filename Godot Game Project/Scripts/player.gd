extends CharacterBody2D

@onready var player_menu = $Camera2D3/Player_Menu
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

# Combat variables
var next_action # store the next action in combat
var statmods = Array() # create an array to store combat stat buffs and debuffs
var defmods = Array() # create an array to store combat on defend buffs and debuffs
var atkmods = Array() # create an array to store combat attack buffs and debuffs

#for save file
signal update_ui 
#var save_file_path = "user://save/"
var save_file_path = "res://Scripts/save/"
var save_file_name = "DemoPlayerSave.tres"
var playerData = PlayerData.new() #you can now access variables from this script
#above is linked to file in Resources > Save2 > PlayerData

func _ready():
	anim_tree.set("parameters/Idle/blend_position",start_dir)
	update_animation_parameter(start_dir) 
	verify_save_directory(save_file_path)

func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)

#load and save
func load_data():
	playerData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	on_start_load()
	print("Loaded the latest saved data!")
func save():
	playerData.day += 1; #add a day when saving
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	print("Saved the game!")
	print(playerData)
	# note current code always overwrites the current save file :/

func on_start_load():
	self.position = playerData.SavePos


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
	interactable()
	# Switch to Idle animation if player physics is paused
	if is_physics_processing() == false:
		state.travel("Idle")
	#updates the direction based on input
	
	#save and load further debugging
	if Input.is_action_just_pressed("save"):
		save()
	if Input.is_action_just_pressed("load"):
		load_data()
	emit_signal("update_ui", playerData.name, playerData.day, self.position)
	playerData.UpdatePos(self.position) #updates player position
	
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
	
#Handles Interact Key press
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		var actionables =  actionable_finder.get_overlapping_areas()
		if actionables.size()>0:
			DialogueFunctions.stop_player_physics()
			actionables[0].action()
			return

#Shows a tooltip above the player stating that what theyre facing is interactable
func interactable():
	var actionables =  actionable_finder.get_overlapping_areas()
	if actionables.size()>0:
		$Label.show()
	else:
		$Label.hide()


# set spawn location
func set_spawn(location: Vector2, direction: Vector2):
	anim_tree.set("parameters/Idle/blend_position",direction)
	position = location

func play_death_animation():
	queue_free()

# Setters for setting stats 
func set_MAX_HP(value:int):
	statsheet.MAX_HP = value

func set_CURR_HP(value:int):
	statsheet.CURR_HP = value

func set_MIN_ATK(value:int):
	statsheet.MIN_ATK = value

func set_MAX_ATK(value:int):
	statsheet.MAX_ATK = value
	
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

func get_MAX_ATK():
	return statsheet.MAX_ATK

func get_MIN_ATK():
	return statsheet.MIN_ATK

func get_DEF():
	return statsheet.DEF

func get_SPD():
	return statsheet.SPD

func get_LCK():
	return statsheet.LCK

func get_ENERGY():
	return statsheet.ENERGY

func get_learned_abilities(index : int):
	return statsheet.learned_abilities[index]

#####################################################
##               COMBAT FUNCTIONS                  ##
#####################################################
func roll_atk():
	var damage = 0
	# check if attack will crit
	if roll_crit():
		damage = get_MAX_ATK() * 2 
	else:
		damage = randi_range(get_MIN_ATK(),get_MAX_ATK())
	
	# Add damage modifiers if they exist
	if atkmods.size() > 0:
		var dmg_increased = 0
		for i in atkmods.size():
			dmg_increased += atkmods[i].apply.call(damage)
		damage += dmg_increased
	
	# reduce number of charges left in each attack modification used by 1
	decrement_atkmods_charges()
	
	# remove attack modifications that have 0 charges left from atkmods array
	remove_expired_atkmods()
	
	# return damage after modifiers
	return damage

func roll_crit():
	var roll = randi_range(1,100)
	if get_LCK() * 5 >= roll:
		return true
	return false
	
func take_damage(damage:int):

	# apply defense stat damage reduction to damage
	damage = damage * (1 - (get_DEF() * 0.05))

	# apply any on defend effects if they exist
	if defmods.size() > 0:
		var dmg_reduced = 0
		for i in defmods.size():
			dmg_reduced += defmods[i].apply.call(damage)
		damage -= dmg_reduced
		
	# reduce number of charges left in each defensive modification used by 1 
	decrement_defmods_charges()
	
	# remove defensive modifications that have 0 charges left from defmods array 
	remove_expired_defmods()
	
	# subtract current hp by resultant damage
	statsheet.CURR_HP -= int(damage)
	
	#check if damage taken is lethal
	if statsheet.CURR_HP <= 0:
		emit_signal("death")
	
	return damage

func heal(value:int):
	statsheet.CURR_HP += value
	statsheet.CURR_HP = mini(statsheet.CURR_HP, statsheet.MAX_HP)
	
#####################################################
##            STATMODS ARRAY FUNCTIONS             ##
#####################################################

# used to subtract the duration of active statmods by 1
func decrement_statmods_duration():
	# check if there are any stat modifications active
	if statmods.size() > 0:
		# reduce duration count by 1 in each modifier
		for i in statmods.size():
			statmods[i].duration -= 1

func remove_expired_statmods():
	# check if there are any stat modifications active
	if statmods.size() > 0:
		# filter the statmods array for elements with a duration higher than 0, removing those that are at 0
		statmods = statmods.filter(remove_statmods_helper)

# helper function to use with filter array function. Returns false (not kept in array) if the statmod has expired, true otherwise
func remove_statmods_helper(ability):
	if ability.duration <= 0:
		ability.remove.call(self)
		return false
	return true

#####################################################
##             DEFMODS ARRAY FUNCTIONS             ##
#####################################################

# used to subtract the duration of active defensive modifications by 1
func decrement_defmods_duration():
	# check if there are any defensive modifications active
	if defmods.size() > 0:
		# reduce duration count by 1 in each modifier
		for i in defmods.size():
			defmods[i].duration -= 1

func decrement_defmods_charges():
	# check if there are any defensive modifications active
	if defmods.size() > 0:
		# reduce duration count by 1 in each modifier
		for i in defmods.size():
			defmods[i].charges -= 1

func remove_expired_defmods():
	# check if there are any defensive modifications active
	if defmods.size() > 0:
		# filter the defmods array for elements with a duration higher than 0, removing those that are at 0
		defmods = defmods.filter(remove_defmods_helper)

# REMOVES FROM DEFMODS ARRAY ONLY. DOES NOT REMOVE ANY STATBUFFS IN STATMODS ARRAY THE ABILITY MIGHT PROVIDE
func remove_defmods_helper(ability):
	if ability.duration <= 0 || ability.charges <= 0:
		return false
	return true

#####################################################
##             ATKMODS ARRAY FUNCTIONS             ##
#####################################################

# used to subtract the duration of active attack modifications by 1
func decrement_atkmods_duration():
	# check if there are any attack modifications active
	if atkmods.size() > 0:
		# reduce duration count by 1 in each modifier
		for i in atkmods.size():
			atkmods[i].duration -= 1

func decrement_atkmods_charges():
	# check if there are any attack modifications active
	if atkmods.size() > 0:
		# reduce duration count by 1 in each modifier
		for i in atkmods.size():
			atkmods[i].charges -= 1

func remove_expired_atkmods():
	# check if there are any attack modifications active
	if atkmods.size() > 0:
		# filter the atkmods array for elements with a duration higher than 0, removing those that are at 0
		atkmods = atkmods.filter(remove_atkmods_helper)

# REMOVES FROM ATKMODS ARRAY ONLY. DOES NOT REMOVE ANY STATBUFFS IN STATMODS ARRAY THE ABILITY MIGHT PROVIDE
func remove_atkmods_helper(ability):
	if ability.duration <= 0 || ability.charges <= 0:
		return false
	return true

