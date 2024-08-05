extends Node
# enum containing the different types an abiity can have 
enum ABILITY_TYPE {
	ATTACK,
	BUFF,
	DEBUFF,
	HEAL,
	ENERGY
}
# function to perform an attack on an enemy. attacker and defender are objects, cost and ability power come from dictionary
func attack(attacker, defender, cost, ability_power):
	# reduce attacker energy by energy cost
	attacker.set_ENERGY(attacker.get_ENERGY() - cost)
	
	# roll attackers damage, apply ability power modifier and apply damage to defender
	var base_damage = attacker.roll_atk()
	var damage = base_damage * ability_power
	return defender.take_damage(damage)
	
	

var ABILITIES = {
	"THINK" : {
		# attributes
		"name" : "Think",
		"ID" : "A_001",
		"energy_cost" : 0,
		"description": "Defend. +10 DEF for 1 turn",
		"learnable": "Yes",
		"type": ABILITY_TYPE.BUFF,
		"duration" : 1,
		
		# functions
		"use": func(attacker):
			# add buff to statmods array
			attacker.statmods.append(ABILITIES.THINK.duplicate())
			
			# set defense increase
			attacker.set_DEF(attacker.get_DEF() + 10),
		"remove": func(attacker):
			# remove defense increase
			attacker.set_DEF(attacker.get_DEF() - 10),
	},
	
	# Enemy version of think
	"DEFEND" : {
		# attributes
		"name" : "Defend",
		"ID" : "A_002",
		"energy_cost" : 0,
		"description": "Defend. +10 DEF for 1 turn",
		"learnable": "Yes",
		"type": ABILITY_TYPE.BUFF,
		"duration" : 1,
		
		# functions
		"use": func(attacker):
			# add buff to statmods array
			attacker.statmods.append(ABILITIES.THINK.duplicate())
			
			# set defense increase
			attacker.set_DEF(attacker.get_DEF() + 10),
		"remove": func(attacker):
			# remove defense increase
			attacker.set_DEF(attacker.get_DEF() - 10),
	},
	
	"TAKE A BREAK"  : {
		# attributes
		"name" : "Take a Break",
		"ID" : "A_003",
		"energy_cost" : 0,
		"description": "Gain 1 extra Energy",
		"learnable": "Yes",
		"type": ABILITY_TYPE.ENERGY,
		
		#functions
		"use": func(attacker):
			attacker.set_ENERGY(attacker.get_ENERGY() + 1)
			return 1,
	},
	
	"WRITE" : {
		# attributes
		"name" : "Write",
		"ID" : "A_004",
		"energy_cost" : 1,
		"description": "Default Attack",
		"learnable": "Yes",
		"type": ABILITY_TYPE.ATTACK,
		"ability_power": 1,

		#functions
		"use": func (attacker, defender):
			return attack(attacker, defender, ABILITIES.WRITE.energy_cost, ABILITIES.WRITE.ability_power),
	},
	
	# Enemy version of write
	"ATTACK" : {
		# attributes
		"name" : "Attack",
		"ID" : "A_005",
		"energy_cost" : 1,
		"description": "Default Attack",
		"learnable": "Yes",
		"type": ABILITY_TYPE.ATTACK,
		"ability_power": 1,

		#functions
		"use": func (attacker, defender):
			return attack(attacker, defender, ABILITIES.ATTACK.energy_cost, ABILITIES.ATTACK.ability_power),
	},
	
	"A_006" : {
		#"ID" : "Multitask",
		#"Energy Cost" : 1,
		#"Learnable": "Yes",
		#"Type": ABILITY_TYPE.ATTACK,
		#"Ability_Power": 0.75,
		#"Description":"Deal 75% Damage to all targets",
	},
	"A_007" : {
		#"ID" : "Brainstorm",
		#"Energy Cost" : 2,
		#"Learnable": "Yes",
		#"Description":"Deal 175% to the primary target and 75% to secondary targets",
	},
	"RESEARCH" : {
		# attributes
		"name" : "Research",
		"ID" : "A_008",
		"energy_cost" : 2,
		"description":" +5 DEF for 1 turn. The next attack is guarenteed to crit and does an extra 50% damage",
		"learnable": "Yes",
		"type": ABILITY_TYPE.BUFF,
		"duration" : 1,
		"charges" : 1,
		
		# functions
		"use" : func (attacker):
			# reduce attacker energy by energy cost 
			attacker.set_ENERGY(attacker.get_ENERGY() - ABILITIES.RESEARCH.energy_cost)
			
			# add to both statmods and atkmods arrays
			attacker.statmods.append(ABILITIES.RESEARCH.duplicate())
			attacker.atkmods.append(ABILITIES.RESEARCH.duplicate())
			
			# add defense and crit 
			attacker.set_DEF(attacker.get_DEF() + 5)
			attacker.set_LCK(attacker.get_LCK() + 20),
		"remove" : func (attacker):
			# remove defense and crit 
			attacker.set_DEF(attacker.get_DEF() - 5)
			attacker.set_LCK(attacker.get_LCK() - 20),
		
		"apply" : func (damage):
			return damage * .5,
	},
	
	"PROOFREAD" : {
		# attributes
		"name" : "Proofread",
		"ID" : "A_009",
		"energy_cost" : 2,
		"description":"Heal for 50% of missing HP. ",
		"learnable": "Yes",
		"type": ABILITY_TYPE.HEAL,
		
		# functions
		"use" : func (attacker):
			# reduce attacker energy by energy cost 
			attacker.set_ENERGY(attacker.get_ENERGY() - ABILITIES.PROOFREAD.energy_cost)
			
			# calculate missing health and heal 50% of it 
			var heal_amount = attacker.get_MAX_HP() - attacker.get_CURR_HP()
			heal_amount = heal_amount / 2
			attacker.heal(heal_amount)
			return heal_amount,
	},
	"A_010" : {
		#"ID" : "Peer Review",
		#"Energy Cost" : 3,
		#"Learnable": "Yes",
		#"Description":"Deals 3 hits of 150% Damage each. Add 1 Damage per hit. Added damage lasts for duration of fight",
	},
	
	"A_011" : {
		#"ID" : "Create a Draft",
		#"Energy Cost" : 3,
		#"Learnable": "Yes",
		#"Description":"Until the end of the fight, At the start of your turn, Deal 75% damage to a random enemy.",
	},
	"A_012" : {
		#"ID" : "Cram",
		#"Energy Cost" : 4,
		#"Learnable": "Yes",
		#"Description":"Gain +10 Damage and +5 to all stats for the rest of the fight",
	},
	
	"BITE" : {
		# attributes
		"name" : "Bite",
		"ID" : "A_013",
		"energy_cost" : 2,
		"description": "Chomp chomp. Deals 225% Damage",
		"learnable": "No",
		"type": ABILITY_TYPE.ATTACK,
		"ability_power": 2.25,
		
		# functions
		"use": func(attacker, defender):
			return attack(attacker, defender, ABILITIES.BITE.energy_cost, ABILITIES.BITE.ability_power),

	},
	
	"DRAIN" : {
		# attributes
		"name": "Drain",
		"ID" : "A_014",
		"energy_cost" : 3,
		"description": "Absorb the strength of your enemies. Deals 275% Damage and heals for 50% of Damage Dealt",
		"learnable": "Yes",
		"type": ABILITY_TYPE.ATTACK,
		"ability_power": 2.75,
		
		# functions
		"use" : func(attacker, defender):
			var damage_dealt = attack(attacker, defender, ABILITIES.DRAIN.energy_cost, ABILITIES.DRAIN.ability_power)
			var healing = damage_dealt / 2 
			attacker.heal(healing)
			return damage_dealt,
	},
	
	"FLURRY OF BOOKS" : {
		#attributes
		"name" : "Flurry of Books",
		"ID" : "A_015",
		"energy_cost" : 3,
		"learnable": "No",
		"type" : ABILITY_TYPE.ATTACK,
		"description":"",
		
	},
}

