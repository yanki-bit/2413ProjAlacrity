extends Node

func _ready():
	print(SelectedAbilities)
	addAbilities("Think")
	print(SelectedAbilities)
	
	var path = "user://data.json"
	
var databaseAbilities = {
	"A_001" : {
		"Ability" : "Think",
		"Energy Cost" : "0",
		"Learnable": "Yes",
		"Description": "Defend. Reduces Incoming Damage by 50% for 1 turn",
	
	},
	"A_002"  : {
		"Ability" : "Take a Break",
		"Energy Cost" : "0",
		"Learnable": "Yes",
		"Description": "Gain 1 extra Energy at the start of the next turn",
	},
	"A_003" : {
		"Ability" : "Write",
		"Energy Cost" : "1",
		"Learnable": "Yes",
		"Description": "Default Attack",
	},
	"A_004" : {
		"Ability" : "Multitask",
		"Energy Cost" : "1",
		"Learnable": "Yes",
		"Description":"Deal 75% Damage to all targets",
	},
	"A_005" : {
		"Ability" : "Brainstorm",
		"Energy Cost" : "2",
		"Learnable": "Yes",
		"Description":"Deal 175% to the primary target and 75% to secondary targets",
	},
	"A_006" : {
		"Ability" : "Research",
		"Energy Cost" : "2",
		"Learnable": "Yes",
		"Description":"Gain 5 Defense for 1 turn. Your next attack is guarenteed to crit and ignores the targets defense",
	},
	
	"A_007" : {
		"Ability" : "Proofread",
		"Energy Cost" : "2",
		"Learnable": "Yes",
		"Description":"Heal for 50% of MAX HP. ",
	},
	"A_008" : {
		"Ability" : "Peer Review",
		"Energy Cost" : "3",
		"Learnable": "Yes",
		"Description":"Deals 3 hits of 150% Damage each. Add 1 Damage per hit. Added damage lasts for duration of fight",
	},
	
	"A_009" : {
		"Ability" : "Create a Draft",
		"Energy Cost" : "3",
		"Learnable": "Yes",
		"Description":"At the start of your turn, Deal 75% damage to a random enemy ",
	},
	"A_010" : {
		"Ability" : "Cram",
		"Energy Cost" : "4",
		"Learnable": "Yes",
		"Description":"Gain +10 Damage and +5 to all stats for the rest of the fight",
	},
	"A_011" : {
		"Ability" : "Bite",
		"Energy Cost" : "2",
		"Learnable": "No",
		"Description": "Chomp chomp. Deals 225% Damage",
	
	},
	"A_012" : {
		"Ability" : "Drain",
		"Energy Cost" : "2",
		"Learnable": "Yes",
		"Description": "Absorb the strength of your enemies. Deals 175% Damage and heals for 50% of Damage Dealt",
	},
	"A_013" : {
		"Ability" : "Flurry of Books",
		"Energy Cost" : "3",
		"Learnable": "No",
		"Description":"",
		
	},
}

var SelectedAbilities = {
	
}

func addAbilities(Ability):
	for i in databaseAbilities:
		if databaseAbilities[i]["Ability"]==Ability:
			var tempDisc = databaseAbilities[i].duplicate(true)
			SelectedAbilities [SelectedAbilities.size()] = tempDisc
			
