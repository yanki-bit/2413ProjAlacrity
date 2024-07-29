extends Control

#custom signals 
#are connected to the canvas layer in room control scene
signal opened
signal closed

var isOpen: bool = false

#preload the resource for Player Inventory
@onready var inventory: Inventory = preload("res://inventory/ninja_inventory/item/playerInventory.tres")
@onready var slots: Array = $NinePatchRect/VBoxContainer.get_children()

#call this at the start
func _ready():
	update()

func update():
	#gui inventory should match inventory resource array
	for i in range (min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func open():
	visible = true
	isOpen = true
	opened.emit()

func close():
	visible = false
	isOpen = false
	closed.emit()
