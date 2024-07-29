## Inventory_UI attached script
extends Control

@onready var inv_container = $NinePatchRect

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalPinventory.inventory_updated.connect(_on_inventory_updated) #no brackets coz we be just calling the function name not the function itself yet
	_on_inventory_updated()
	

#  use a connector function for inventory UI
# connectors are connected to signals
func _on_inventory_updated():
	#clear the slots
	clear_inv_container()
	#add slots for each inventory position
	for item in GlobalPinventory.p_inventory:
		var slot = GlobalPinventory.inventory_slot_scene.instantiate()
		inv_container.add_child(slot)
		if item != null:
			slot.set_item(item)
		else: 
			slot.set_empty()
	
#clears up all slots
func clear_inv_container():
	while inv_container.get_child_count() > 0:
		var child = inv_container.get_child(0)
		inv_container.remove_child(child)
		child.queue_free()



