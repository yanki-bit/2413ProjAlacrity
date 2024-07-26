extends Node
enum ABILITY_TYPE {
	ATTACK,
	ON_ATTACK,
	ON_ATTACKED,
	BUFF,
	ENEMY_BUFF,
	OTHER
}

var ABILITIES = {
	"A_001" : {
		"Name" : "Think",
		"Energy Cost" : 0,
		"Duration" : 1,
		"Type": ABILITY_TYPE.BUFF,
		"Learnable": "Yes",
		"Description": "Defend. Reduce incoming damage by 50% until the start of your next turn",
	},
	"A_002"  : {
		"Name" : "Take a Break",
		"Energy Cost" : 0,
		"Type": ABILITY_TYPE.OTHER,
		"Learnable": "Yes",
		"Description": "Gain 1 extra Energy",
	},
	"A_003" : {
		"Name" : "Write",
		"Energy Cost" : 1,
		"Type": ABILITY_TYPE.ATTACK,
		"Learnable": "Yes",
		"Description": "Default Attack",
		
	},
	"A_004" : {
		"Name" : "Multitask",
		"Energy Cost" : 1,
		"Learnable": "Yes",
		"Type": ABILITY_TYPE.ATTACK,
		"Description":"Deal 75% Damage to all targets",
	},
	"A_005" : {
		"Name" : "Brainstorm",
		"Energy Cost" : 2,
		"Learnable": "Yes",
		"Description":"Deal 175% to the primary target and 75% to secondary targets",
	},
	"A_006" : {
		"Name" : "Research",
		"Energy Cost" : 2,
		"Learnable": "Yes",
		"Type": [ABILITY_TYPE.BUFF, ABILITY_TYPE.ON_ATTACK],
		"Description":" +5 DEF until your next turn. Your next attack is guarenteed to crit and ignores the targets defense",
	},
	
	"A_007" : {
		"Name" : "Proofread",
		"Energy Cost" : 2,
		"Learnable": "Yes",
		"Description":"Heal for 50% of missing HP. ",
	},
	"A_008" : {
		"Name" : "Peer Review",
		"Energy Cost" : 3,
		"Learnable": "Yes",
		"Description":"Deals 3 hits of 150% Damage each. Add 1 Damage per hit. Added damage lasts for duration of fight",
	},
	
	"A_009" : {
		"Name" : "Create a Draft",
		"Energy Cost" : 3,
		"Learnable": "Yes",
		"Description":"Until the end of the fight, At the start of your turn, Deal 75% damage to a random enemy.",
	},
	"A_010" : {
		"Name" : "Cram",
		"Energy Cost" : 4,
		"Learnable": "Yes",
		"Description":"Gain +10 Damage and +5 to all stats for the rest of the fight",
	},
	"A_011" : {
		"Name" : "Bite",
		"Energy Cost" : 2,
		"Learnable": "No",
		"Type": ABILITY_TYPE.ATTACK,
		"Description": "Chomp chomp. Deals 225% Damage",
	
	},
	"A_012" : {
		"Name" : "Drain",
		"Energy Cost" : 2,
		"Learnable": "Yes",
		"Type": ABILITY_TYPE.ATTACK,
		"Description": "Absorb the strength of your enemies. Deals 175% Damage and heals for 50% of Damage Dealt",
	},
	"A_013" : {
		"Name" : "Flurry of Books",
		"Energy Cost" : 3,
		"Learnable": "No",
		"Type" : ABILITY_TYPE.ATTACK,
		"Description":"",
		
	},
}
