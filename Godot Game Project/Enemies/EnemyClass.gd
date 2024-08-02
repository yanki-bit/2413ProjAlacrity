# Class that all enemy units are a part of
class_name EnemyClass extends Area2D

signal contact
signal death

# Enemy Information
enum EnemyType { Minion, Mini_Boss, Boss }
var Name: String
@export var type: EnemyType
var minion = [] # array to store minions in cases where main enemy has more than 1 type of minion
var this_scene: String
# @export var minion: String

# Enemy Statsheet
@export var statsheet: Resource

# reference to battle scene
var battle_scene = preload("res://Game/battle_scene.tscn")

# Combat variables
var next_action # store the next action in combat
var statmods = Array() # create an array to store combat stat buffs and debuffs
var defmods = Array() # create an array to store combat on defend buffs and debuffs
var atkmods = Array() # create an array to store combat attack buffs and debuffs

# Stat variables
var MAX_HP: int
var CURR_HP: int 
var MIN_ATK: int
var MAX_ATK: int
var DEF: int
var SPD: int
var LCK: int
var ENERGY: int

# Array of learned abilities
var learned_abilities


# give the unit stats, functionality temporary for testing, should grab information from database not pass by value
func show_on_map():
	show()
	$AnimationPlayer.play("default")

func show_in_fight():
	# Change scale from map size to combat size
	scale.x = 4
	scale.y = 4
	show()
	$AnimationPlayer.play("combat")

func initalize_combat():
	# Generate random number of minions (0,1 or 2) based on if it has minions
	var numberOfMinions: int
	if type == EnemyType.Minion:
		numberOfMinions = 0
	elif type == EnemyType.Boss:
		numberOfMinions = 2
	else:
		numberOfMinions = generate_number_of_minions()
	
	# pause game
	get_tree().paused = true

	# Create instance of Battle Scene and add enemies to it
	var fight = battle_scene.instantiate()
	
	#puts fight scene into tree
	get_parent().add_child(fight)
	
	# Adds enemies to the fight !!! 0 FOR TESTING ONLY SHOULD BE numberOfMinions
	fight.add_enemies(this_scene, minion, 0)	
	
	
	
	#free queue to prevent continuous battles spawning
	queue_free()

# Initialize stats in combat
func initialize_stats_in_combat():
	MAX_HP = statsheet.MAX_HP
	CURR_HP = statsheet.CURR_HP
	MIN_ATK = statsheet.MIN_ATK
	MAX_ATK = statsheet.MAX_ATK
	DEF = statsheet.DEF
	SPD = statsheet.SPD
	LCK = statsheet.LCK
	ENERGY = statsheet.ENERGY
	learned_abilities = statsheet.learned_abilities
	

# Generate the number of minions to spawn with this enemy
func generate_number_of_minions() -> int:
	var numberOfMinions = randi_range(0,2)
	return numberOfMinions

func play_death_animation():
	queue_free()
	pass


# Setters for setting stats 
func set_MAX_HP(value:int):
	MAX_HP = value

func set_CURR_HP(value:int):
	CURR_HP = value

func set_MIN_ATK(value:int):
	MIN_ATK = value

func set_MAX_ATK(value:int):
	MAX_ATK = value

func set_DEF(value:int):
	DEF = value

func set_SPD(value:int):
	SPD = value

func set_LCK(value:int):
	LCK = value

func set_ENERGY(value:int):
	ENERGY = value

# Getters for stats
func get_Name():
	return Name

func get_MAX_HP():
	return MAX_HP

func get_CURR_HP():
	return CURR_HP

func get_MIN_ATK():
	return MIN_ATK

func get_MAX_ATK():
	return MAX_ATK

func get_DEF():
	return DEF

func get_SPD():
	return SPD

func get_LCK():
	return LCK

func get_ENERGY():
	return ENERGY

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
	CURR_HP -= int(damage)
	
	#check if damage taken is lethal
	if CURR_HP <= 0:
		emit_signal("death")
	
	return damage

func heal(value:int):
	CURR_HP += value
	CURR_HP = mini(CURR_HP, MAX_HP)

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

func empty_statmods_array():
	for i in statmods.size():
		statmods[i].remove.call()
	statmods.clear()
	
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
