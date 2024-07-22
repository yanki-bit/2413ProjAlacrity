extends Node

func _ready():
	print(SelectedEnemies)
	addItems("Vampire Book")
	print(SelectedEnemies)
var databaseEnemies = {
	001 : {
		"Name" : "Vampire Book",
		"Description": "",
	},
	002 : {
		"Name" : "Count Bookshelf",
		"Description": "",
	},
	003 : {
		"Name" : "Monitor",
		"Description": "",
	},
	004 : {
		"Name" : "Keyboard",
		"Description": "",
	},
	005 : {
		"Name" : "Mouse",
		"Description": "",
	},
	006 : {
		"Name" : "PC Tower",
		"Description": "",
	},
	007 : {
		"Name" : "Exam Booklet",
		"Description": "",
	},
	008 : {
		"Name" : "Scantron Sheet",
		"Description": "",
	},
	
}

var SelectedEnemies = {
	
}

func addItems(Name):
	for i in databaseEnemies:
		if databaseEnemies[i]["Name"]==Name:
			var tempDisc = databaseEnemies[i].duplicate(true)
			SelectedEnemies [SelectedEnemies.size()] = tempDisc
			
