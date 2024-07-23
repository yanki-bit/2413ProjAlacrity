## this is an autoload global script, variables can be accessed project wide (or globally)
## attach in project settings > autoload tab
## coded by Yankidoodle
## global_pinventory script

extends Node

# create an array that holds all player items
var p_inventory = []

# custom signals
signal inventory_updated

#scene and node references
var player_node: Node = null
@onready var inventory_slot_scene = preload("res://inventory/test_pinventory/Inventory_Slot.tscn")
 
func _ready():
	#intializes the inventory with 20 slots
	p_inventory.resize(9)

#references player for inventory interactions
func set_player_reference(player):
	player_node = player


#reference an item that is a part of group of Items
func add_item(item):
	for i in range(p_inventory.size()):
		#
		#if p_inventory[i] != null and p_inventory[i]["item_type"] == item["item_type"] and p_inventory[i]["item_name"] == item["item_name"]:
		#match the names with the item pickup in inventory item
		if p_inventory[i] != null and ( p_inventory[i]["quantity"] != 0 and p_inventory[i]["item_name"] == item["item_name"] ):
			# match the stuff with the dictionary
			# if they match stack them by increasing the quantity variable from item dictionary in inventory_item script
			p_inventory[i]["quantity"] += item["quantity"]
			inventory_updated.emit() #call this signal when an item is added
			print("Item added to inventory and stacked", p_inventory)
			return true
			
		# below is for empty slots w/ no items
		elif p_inventory == null:
			#place new item and emit signal
			p_inventory[i] = item
			inventory_updated.emit()
			print("Item added to inventory", p_inventory)
			return true 
	return false #default if there is no empty slot and stackable item
		

func remove_item():
	inventory_updated.emit() #call this signal when an item is removed
	
func increase_inventory_size():
	inventory_updated.emit()


	
