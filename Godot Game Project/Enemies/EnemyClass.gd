# Class that all enemy units are a part of
class_name EnemyClass extends Area2D

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

# Stat variables
var MAX_HP: int
var CURR_HP: int 
var ATK: int
var DEF: int
var SPD: int
var LCK: int


# placeholder var, will be changed dictionary taken from database
var Abilities


# give the unit stats, functionality temporary for testing, should grab information from database not pass by value
func show_on_map():
	show()
	$AnimationPlayer.play("default")

func show_in_fight():
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
	
	print(numberOfMinions)
	
	# pause game
	get_tree().paused = true

	# Create instance of Battle Scene and add enemies to it
	var fight = battle_scene.instantiate()
	
	#puts fight scene into tree
	get_parent().add_child(fight)
	
	# Adds enemies to the fight !!! 0 FOR TESTING ONLY SHOULD BE NUMBEROFMINIONS
	fight.add_enemies(this_scene, minion, numberOfMinions)	
	
	
	
	#free queue to prevent continuous battles spawning
	queue_free()

func initialize_stats_in_combat():
	MAX_HP = statsheet.MAX_HP
	CURR_HP = statsheet.CURR_HP
	ATK = statsheet.ATK
	DEF = statsheet.DEF
	SPD = statsheet.SPD
	LCK = statsheet.LCK
	

# Generate the number of minions to spawn with this enemy
func generate_number_of_minions() -> int:
	var numberOfMinions = randi_range(0,2)
	return numberOfMinions

# Getters and Setters for changing stats
func set_MAX_HP(value:int):
	MAX_HP = value
	pass

func take_damage(value:int):
	CURR_HP -= value
	if CURR_HP <= 0:
		emit_signal("death")
	pass

func heal(value:int):
	CURR_HP += value
	CURR_HP = maxi(CURR_HP, MAX_HP)
