extends Resource

class_name Inventory

#Inventory Item is another resource
@export var items: Array[InventoryItem]

#adding items to inventory upon pickup
func insert(item: InventoryItem):
	pass
