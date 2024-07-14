class_name EnemyClass extends Area2D
# Class that all enemy units are a part of

enum EnemyType { Minion, Boss }
# Enemy Information
var Name: String
var type: EnemyType
@export var minion: EnemyClass
@export var stats: Resource

# Enemy Stats

# placeholder var, will be changed dictionary taken from database
var Abilities


# give the unit stats, functionality temporary for testing, should grab information from database not pass by value

func show_on_map():
	show()
	$AnimatedSprite2D.play("default")

func show_in_fight():
	show()
	$AnimatedSprite2D.play("default")
	
func generate_number_of_minions() -> int:
	var numberOfMinions = randi_range(0,2)
	return numberOfMinions
