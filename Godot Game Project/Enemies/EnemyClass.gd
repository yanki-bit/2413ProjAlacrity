class_name EnemyClass extends Area2D
# Class that all enemy units are a part of

enum EnemyType { Minion, Boss }
# Enemy Information
var Name: String
var type: EnemyType
var minion: EnemyClass
# Enemy Stats
var HP: int
var ATK: int
var DEF: int
var SPD: int
var LCK: int
# placeholder var, will be changed dictionary taken from database
var Abilities


# give the unit stats, functionality temporary for testing, should grab information from database not pass by value
func add_stats(name: String, hp: int, atk: int, def: int, spd: int, lck: int):
	Name = name
	HP = hp
	ATK = atk
	DEF = def 
	SPD = spd
	LCK = lck

func show_on_map():
	show()
	$AnimatedSprite2D.play("default")

func show_in_fight():
	show()
	$AnimatedSprite2D.play("default")
	
func generate_number_of_minions() -> int:
	var numberOfMinions = randi_range(0,2)
	return numberOfMinions
