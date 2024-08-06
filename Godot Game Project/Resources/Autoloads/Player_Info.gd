extends Node
var player_name = "Justin"
var score = 0
var acad = 0

var day = 0
var part = ["Early Morning", "Late Morning", "Afternoon", "Evening"]
var time = 0

var state: Dictionary = {
	"Bedroom":
		false,
	"Classroom":
		false,
	"Library":
		false,
	"Hallway":
		false
	}

var equipped_weapon : Dictionary
var equipped_armor : Dictionary
var equipped_accessory : Dictionary

#callable function to add to game day
func add_game_day(AddDay = 1) -> void:
	day += AddDay
