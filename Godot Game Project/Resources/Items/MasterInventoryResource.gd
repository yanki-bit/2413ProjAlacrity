
class_name MasterInventoryResource
extends Resource
#Will contain a list of weapons we have in the game
var weapons_dict = {
	"Pencil": {
		"name" : "Pencil",
		"atk" : 1,
		"description" : "A No.2 Pencil. Carried since grade school. Short and Pathetic"
	},
	
	"Pen": {
		"name" : "Pen",
		"atk" : 2,
		"description" : "How have you not lost this yet??"
		},
	
	"Highlighter": {
		"name" : "Highlighter",
		"atk" : 3,
		"description" : "Highlights in a terrible yellow smeared with black"
		},
		
	"MechanicalPencil": {
		"name" : "Mechanical Pencil",
		"atk" : 4,
		"description" : "You thought this would motivate you to write notes more"
		},
		
	"FountainPen": {
		"name" : "Fountain Pen",
		"atk" : 5,
		"description" : "Did you really need this pen or was it just an impulse buy?"
	}
}

var armor_dict ={
	"Hoodie": {
		"name" : "Hoodie",
		"hp" : 10,
		"def" : 2,
		"description" : "Good enough for school, don't wear it to an inteview"
	},
	"Shirt": {
		"name" : "Button Down Shirt",
		"hp" : 25,
		"def" : 3,
		"description" : "All you need is a tie"
	},
	"Jacket": {
		"name" : "Denim Jacket",
		"hp" : 40,
		"def" : 4,
		"description" : "Rugged and Resilient, A classic cowboy look"
	}
}

var acc_dict = {
	"shoes" : {
		"name" : "Shoes",
		"def" : 1,
		"spd" : 1,
		"lck" : 0,
		"description" : "Satisfactory"
	},
	"sunglasses" : {
		"name" : "Sunglasses",
		"def" : 2,
		"spd" : 0,
		"lck" : 0,
		"description" : "Hides your tears, but not your shame"
	},
	"watch" : {
		"name" : "Calculator Watch",
		"def" : 1,
		"spd" : 0,
		"lck" : 1,
		"description" : "Wearable reminder that you're running late. Does Math"
	},
	"dice" : {
		"name" : "Dice",
		"def" : 0,
		"spd" : 0,
		"lck" : 2,
		"description" : "Four-sided, you use it to gamble multiple choice questions"
	}
}

var usable_dict = {
	"water" : {
		"name" : "Water Bottle",
		"hp" : 15,
		"def" : 1,
		"spd" : 1,
		"lck" : 1,
		"description" : "Stay hydrated"
	},
	"NRG" : {
		"name" : "Energy Drink",
		"hp" : 5,
		"def" : 0,
		"spd" : 5,
		"lck" : 0,
		"description" : "180mg of pure unregulated Caffeine. A poison that unlocks your mind."
	},
	"sandwich" : {
		"name" : "Sammy",
		"hp" : 75,
		"def" : 0,
		"spd" : 0,
		"lck" : 0,
		"description" : "Sandwich, bread, lettuce, cheese, tomato, mustard, bread, crumble - Earl Sweatshirt"
	},
	"eraser" : {
		"name" : "Eraser",
		"hp" : 0,
		"def" : 15,
		"spd" : 0,
		"lck" : 0,
		"description" : "To clean up mistakes, too bad it doesn't work on you."
	}
}
			
