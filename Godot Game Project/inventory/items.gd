extends Node

var databaseItems = {
	"I_101" : {
		"Item" : "Pencil",
		"Type" : "Weapon",
		"Description": "A No. 2 Pencil. You've used since Grade School",
		"Price" : "$1",
		"Stat": {
			"Min_Atk": 4,
			"Max_Atk": 7,
			},
		"equip" : func (player):
			player.set_MIN_ATK(player.get_MIN_ATK() + 4)
			player.set_MAX_ATK(player.get_MAX_ATK() + 7),
			
		"unequip" : func (player):
			player.set_MIN_ATK(player.get_MIN_ATK() - 4)
			player.set_MAX_ATK(player.get_MAX_ATK() - 7),
		},
		
	"I_102" : {
		"Item" : "Pen",
		"Type" : "Weapon",
		"Description": "A cheap pen for a cheap person",
		"Price" : "$1",
		"Stat": {
			"Min_Atk": 5,
			"Max_Atk": 8,
			},
		"equip" : func (player):
			player.set_MIN_ATK(player.get_MIN_ATK() + 5)
			player.set_MAX_ATK(player.get_MAX_ATK() + 8),
			
		"unequip" : func (player):
			player.set_MIN_ATK(player.get_MIN_ATK() - 5)
			player.set_MAX_ATK(player.get_MAX_ATK() - 8),
	},
	"I_103" : {
		"Item" : "Highlighter",
		"Type" : "Weapon",
		"Description": "Highlight Key phrases. Not for coloring",
		"Price" : "$1",
		"Stat": {
			"Min_Atk": 6,
			"Max_Atk": 9,
			}
	},
	"I_104" : {
		"Item" : "Mechanical Pencil",
		"Type" : "Weapon",
		"Description": "0.7mm lead. A serious pencil for the serious student",
		"Price" : "$1",
		"Stat": {
			"Min_Atk": 7,
			"Max_Atk": 10,
			}
	},
	"I_105" : {
		"Item" : "Fountain Pen",
		"Type" : "Weapon",
		"Description": "A sophisticated writing instrument for those with discerning taste",
		"Price" : "$1",
		"Stat": {
			"Min_Atk": 8,
			"Max_Atk": 11,
			}
	},
	"I_201" : {
		"Item" : "Water Bottle",
		"Type" : "Usable",
		"Description": "Default drink for humans around the world",
		"Price" : "$1",
		"Stat" : {
			"Hp": 20
		}
	},
	"I_202" : {
		"Item" : "Energy Drink",
		"Type" : "Usable",
		"Description": "166mg of caffeine and 54g of sugar. It's basically poison but atleast you'll be energized",
		"Price" : "$1",
		"Stat" : {
			"Hp": 25
		}
	},
	"I_203" : {
		"Item" : "Sandwich",
		"Type" : "Usable",
		"Description": "A Ham and Cheese BLT, its got all the food groups",
		"Price" : "$1",
		"Stat" : {
			"Hp": 50
		}
	},
	"I_204" : {
		"Item" : "Eraser",
		"Type" : "Usable",
		"Description": "A delete button for your mistakes",
		"Price" : "$1",
		"Stat": {
			"Hp": 100
			}
	},
	"I_301" : {
		"Item" : "Shoes",
		"Type" : "Accessory",
		"Description": "They're no Jordans, but atleast your toes are covered",
		"Price" : "$1",
		"Stat": {
			"Spd": 1
			}
	},
	"I_302" : {
		"Item" : "Sunglasses",
		"Type" : "Accessory",
		"Description": "Protects your eyes from the sun, doesn't look worn indoors",
		"Price" : "$1",
		"Stat": {
			"Spd": 2
			}
	},
	"I_303" : {
		"Item" : "Calculator watch",
		"Type" : "Accessory",
		"Description": "A wearable reminder that you're running late. Also does math",
		"Price" : "$1",
		"Stat": {
			"Spd": 3
			}
	},
	"I_304" : {
		"Item" : "Dice",
		"Type" : "Accessory",
		"Description": "A four sided dice, useful for multiple choice questions during exams",
		"Price" : "$1",
		"Stat": {
			"Spd": 4
			}
	},
	"I_401" : {
		"Item" : "Hoodie",
		"Type" : "Armor",
		"Description": "Good enough for school, don't wear it to an interview",
		"Price" : "$1",
		"Stat": {
			"Def": 1
			}
	},
	"I_402" : {
		"Item" : "Button Down Shirt",
		"Type" : "Armor",
		"Description": "Now you just need a tie",
		"Price" : "$1",
		"Stat": {
			"Def": 2
			}
	},
	"I_403" : {
		"Item" : "Denim Jacket",
		"Type" : "Armor",
		"Description": "Rugged and Resilient. A classic cowboy look",
		"Price" : "$1",
		"Stat": {
			"Def": 3
			}
	},
}
