extends Node

func _ready():
	print(SelectedEnemies)
	addItems("Vampire Book")
	print(SelectedEnemies)
	
var path = "user://data.json"
	
var databaseEnemies = {
	"E_001" : {
		"Name" : "Vampire Book",
		"Description": "",
		"HP": "25",
		"ATK": "5",
		"DEF": "5",
		"SPD": "1",
		"LCK": "1",
	},
	"E_002" : {
		"Name" : "Count Bookshelf",
		"Description": "",
		"HP": "",
		"ATK": "",
		"DEF": "",
		"SPD": "",
		"LCK": "",
	},
	"E_003" : {
		"Name" : "Monitor",
		"Description": "",
		"HP": "",
		"ATK": "",
		"DEF": "",
		"SPD": "",
		"LCK": "",
	},
	"E_004": {
		"Name" : "Keyboard",
		"Description": "",
		"HP": "",
		"ATK": "",
		"DEF": "",
		"SPD": "",
		"LCK": "",
	},
	"E_005": {
		"Name" : "Mouse",
		"Description": "",
		"HP": "",
		"ATK": "",
		"DEF": "",
		"SPD": "",
		"LCK": "",
	},
	"E_006" : {
		"Name" : "PC Tower",
		"Description": "",
		"HP": "",
		"ATK": "",
		"DEF": "",
		"SPD": "",
		"LCK": "",
	},
	"E_007" : {
		"Name" : "Exam Booklet",
		"Description": "",
		"HP": "",
		"ATK": "",
		"DEF": "",
		"SPD": "",
		"LCK": "",
	},
	"E_008" : {
		"Name" : "Scantron Sheet",
		"Description": "",
		"HP": "",
		"ATK": "",
		"DEF": "",
		"SPD": "",
		"LCK": "",
	},
	
}

var SelectedEnemies = {
	
}

func addItems(Name):
	for i in databaseEnemies:
		if databaseEnemies[i]["Name"]==Name:
			var tempDisc = databaseEnemies[i].duplicate(true)
			SelectedEnemies [SelectedEnemies.size()] = tempDisc
			
