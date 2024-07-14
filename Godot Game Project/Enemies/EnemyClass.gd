class_name EnemyClass extends Area2D
# Class that all enemy units are a part of

enum EnemyType { Minion, Boss }
# Enemy Information
var Name: String
var type: EnemyType
@export var minion: EnemyClass

# Enemy Statsheet
@export var statsheet: Resource

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
	$AnimatedSprite2D.play("default")

func show_in_fight():
	show()
	$AnimatedSprite2D.play("default")

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

