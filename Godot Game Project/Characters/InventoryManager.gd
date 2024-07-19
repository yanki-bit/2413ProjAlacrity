extends Node
class_name InventoryManager
#Inventory Dictionary
var inventory = {}

var master_inventory

func _ready():
	master_inventory = preload("res://Scenes/Resources/Items/MasterInventoryResource.tres")
	
#Function to add an item to the inventory
func add_item(category,item_name, quantity = 1):
	var item = null
	match category:
		"Weapon":
			item = master_inventory.weapons_dict[item_name]
		"Armor":
			item = master_inventory.armor_dict[item_name]
		"Accessory":
			item = master_inventory.acc_dict[item_name]
		"Consumable":
			item = master_inventory.usable_dict[item_name]
			
	if item:
		if inventory.has(item_name):
			inventory[item_name]["quantity"] += quantity
		else:
			inventory[item_name] = {"name" : item_name, "quantity": quantity, "category": category}
	else:
		print("Item not found in Master Inventory")

#Function to remove an item from the inventory
func remove_item(item_name, quantity = 1) -> void:
	if inventory.has(item_name):
		inventory[item_name]["quantity"] -= quantity
		if inventory[item_name]["quantity"] <= 0:
			inventory.erase(item_name)
		else:
			print("Item not found in inventory!")
#function to get item data
func get_item(item_name):
	if inventory.has(item_name):
		return inventory[item_name]
	else:
		return null

#function to check if an item exists in inventory
func has_item(item_name):
	return inventory.has(item_name)

#function to get the total number of items in inventory
func get_total_items():
	var total = 0
	for item in inventory.values():
		total += item["quantity"]
	return total
