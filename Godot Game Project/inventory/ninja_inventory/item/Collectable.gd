extends Area2D

#holds the inventory item resource
@export var itemRes: InventoryItem

func collect(inventory: Inventory):
	inventory.insert(itemRes)
	queue_free()

func collected():
	queue_free()
