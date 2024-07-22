extends Node

func _ready():
	print(SelectedItems)
	addItems("Pen")
	print(SelectedItems)
var databaseItems = {
	101 : {
		"Item" : "Pencil",
		"Type" : "Weapon",
		"Description": "A No. 2 Pencil. You've used since Grade School",
		"Price" : "$1",
	},
	102 : {
		"Item" : "Pen",
		"Type" : "Weapon",
		"Description": "A cheap pen for a cheap person",
		"Price" : "$1",
	},
	103 : {
		"Item" : "Highlighter",
		"Type" : "Weapon",
		"Description": "Highlight Key phrases. Not for coloring",
		"Price" : "$1",
	},
	104 : {
		"Item" : "Mechanical Pencil",
		"Type" : "Weapon",
		"Description": "0.7mm lead. A serious pencil for the serious student",
		"Price" : "$1",
	},
	105 : {
		"Item" : "Fountain Pen",
		"Type" : "Weapon",
		"Description": "A sophisticated writing instrument for those with discerning taste",
		"Price" : "$1",
	},
	201 : {
		"Item" : "Water Bottle",
		"Type" : "Usable",
		"Description": "Default drink for humans around the world",
		"Price" : "$1",
	},
	202 : {
		"Item" : "Energy Drink",
		"Type" : "Usable",
		"Description": "166mg of caffeine and 54g of sugar. It's basically poison but atleast you'll be energized",
		"Price" : "$1",
	},
	203 : {
		"Item" : "Sandwich",
		"Type" : "Usable",
		"Description": "A Ham and Cheese BLT, its got all the food groups",
		"Price" : "$1",
	},
	204 : {
		"Item" : "Eraser",
		"Type" : "Usable",
		"Description": "A delete button for your mistakes",
		"Price" : "$1",
	},
	301 : {
		"Item" : "Shoes",
		"Type" : "Accessory",
		"Description": "They're no Jordans, but atleast your toes are covered",
		"Price" : "$1",
	},
	302 : {
		"Item" : "Sunglasses",
		"Type" : "Accessory",
		"Description": "Protects your eyes from the sun, doesn't look worn indoors",
		"Price" : "$1",
	},
	303 : {
		"Item" : "Calculator watch",
		"Type" : "Accessory",
		"Description": "A wearable reminder that you're running late. Also does math",
		"Price" : "$1",
	},	
	304 : {
		"Item" : "Dice",
		"Type" : "Accessory",
		"Description": "A four sided dice, useful for multiple choice questions during exams",
		"Price" : "$1",
	},
	401 : {
		"Item" : "Hoodie",
		"Type" : "Clothes",
		"Description": "Good enough for school, don't wear it to an interview",
		"Price" : "$1",
	},
	402 : {
		"Item" : "Button Down Shirt",
		"Type" : "Clothes",
		"Description": "Now you just need a tie",
		"Price" : "$1",
	},
	403 : {
		"Item" : "Denim Jacket",
		"Type" : "Clothes",
		"Description": "Rugged and Resilient. A classic cowboy look",
		"Price" : "$1",
	},
}

var SelectedItems = {
	
}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func addItems(Item):
	for i in databaseItems:
		if databaseItems[i]["Item"]==Item:
			var tempDisc = databaseItems[i].duplicate(true)
			SelectedItems [SelectedItems.size()] = tempDisc
			

