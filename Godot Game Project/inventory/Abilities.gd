extends Node

func _ready():
	print(SelectedAbilities)
	addAbilities("Think")
	print(SelectedAbilities)
var databaseAbilities = {
	001 : {
		"Ability" : "Think",
		"Energy Cost" : 0,
		"Learnable": "Yes",
		"Description": "Defend. Reduces Incoming Damage by 50% for 1 turn"
	
	},
	002 : {
		"Ability" : "Take a Break",
		"Energy Cost" : 0,
		"Learnable": "Yes",
		"Description": "Gain 1 extra Energy at the start of the next turn"
	},
	003 : {
		"Ability" : "Write",
		"Energy Cost" : 1,
		"Learnable": "Yes",
		"Description": "Default Attack"
	},
	004 : {
		"Ability" : "Multitask",
		"Learnable": "Yes",
	},
	005 : {
		"Ability" : "Brainstorm",
		"Learnable": "Yes",
	},
	006 : {
		"Ability" : "Proofread",
		"Learnable": "Yes",
	},
	007 : {
		"Ability" : "Peer Review",
		"Learnable": "Yes",
	},
	008 : {
		"Ability" : "Research",
		"Learnable": "Yes",
	},
	009 : {
		"Ability" : "Create a Draft",
		"Learnable": "Yes",
	},
	010 : {
		"Ability" : "Cram",
		"Learnable": "Yes",
	},
	101 : {
		"Ability" : "Bite",
		"Energy Cost" : 2,
		"Learnable": "No",
		"Description": "Chomp chomp. Deals 225% Damage"
	
	},
	102 : {
		"Ability" : "Drain",
		"Energy Cost" : 2,
		"Learnable": "Yes",
		"Description": "Absorb the strength of your enemies. Deals 175% Damage and heals for 50% of Damage Dealt",
	},
	103 : {
		"Ability" : "Flurry of Books",
		"Energy Cost" : 3,
		"Learnable": "No",
		
	},
}

var SelectedAbilities = {
	
}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func addAbilities(Ability):
	for i in databaseAbilities:
		if databaseAbilities[i]["Ability"]==Ability:
			var tempDisc = databaseAbilities[i].duplicate(true)
			SelectedAbilities [SelectedAbilities.size()] = tempDisc
			
