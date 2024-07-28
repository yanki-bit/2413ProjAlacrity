extends Node
# enum containing the different types an abiity can have 
enum ABILITY_TYPE {
	ATTACK,
	ON_ATTACK,
	ON_DEFEND,
	BUFF,
	DEBUFF,
	HEAL,
	ENERGY
}

var ABILITIES = {
	"A_001" : {
		"name" : "Think",
		"energy_cost" : 0,
		"duration" : 1,
		"type": ABILITY_TYPE.BUFF,
		"learnable": "Yes",
		"description": "Defend. +10 DEF until the start of your next turn",
		"use": func(attacker):
			attacker.statmod.append(ABILITIES.A_001.duplicate())
			attacker.set_DEF(attacker.get_DEF() + 10),
		"remove": func(attacker):
			attacker.set_DEF(attacker.get_DEF() - 10),
	},
	"A_002"  : {
		"Name" : "Take a Break",
		"Energy Cost" : 0,
		"Type": ABILITY_TYPE.ENERGY,
		"Learnable": "Yes",
		"Description": "Gain 1 extra Energy",
		"use": func(attacker):
			attacker.set_ENERGY(attacker.get_ENERGY() + 1),
	},
	"A_003" : {
		"Name" : "Write",
		"Energy Cost" : 1,
		"Type": ABILITY_TYPE.ATTACK,
		"Learnable": "Yes",
		"Ability_Power": 1,
		"Description": "Default Attack",
		"use": func (attacker, defender) -> void:
			var base_damage = attacker.roll_atk()
			var damage = base_damage * ABILITIES.A_003.Ability_Power 
			defender.take_damage(damage),
	},
	"A_004" : {
		"Name" : "Multitask",
		"Energy Cost" : 1,
		"Learnable": "Yes",
		"Type": ABILITY_TYPE.ATTACK,
		"Ability_Power": 0.75,
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
		"Ability_Power": 2.25,
		"Description": "Chomp chomp. Deals 225% Damage",
	
	},
	"A_012" : {
		"Name" : "Drain",
		"Energy Cost" : 2,
		"Learnable": "Yes",
		"Type": ABILITY_TYPE.ATTACK,
		"Ability_Power": 1.75,
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

