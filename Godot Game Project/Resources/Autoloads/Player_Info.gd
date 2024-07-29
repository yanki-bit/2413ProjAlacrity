extends Node
class_name Player_Name
var player_name = "Justin"
var score = 0
var acad = 0
var day = 0
var state: Dictionary = {
	"Bedroom":
		false,
	"Classroom":
		false,
	"Library":
		false
	}
#callable function to add to game day
func add_game_day(AddDay = 1) -> void:
	day += AddDay
