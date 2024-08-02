extends Control
@onready var weapon_container = $VBoxContainer/Inventory_Items_Container/MarginContainer/Weapon_List_Container
@onready var armor_container = $VBoxContainer/Inventory_Items_Container/MarginContainer/Armor_List_Container
@onready var acc_container = $VBoxContainer/Inventory_Items_Container/MarginContainer/Accessory_List_Container
@onready var inventory_items_container = $VBoxContainer/Inventory_Items_Container

var slot_scene = preload("res://Menu/Player Menu/inventory_slot.tscn")
#buttons
@onready var weapon_btn = $VBoxContainer/Equipment_Options/Weapon_btn 
@onready var armor_btn = $VBoxContainer/Equipment_Options/Armor_btn 
@onready var accessory_btn = $VBoxContainer/Equipment_Options/Accessory_btn 
var items_data
func _ready():
	load_items()
	
#Handles behaviour when button in group is pressed
func _handle_button_toggled(toggledOn: bool, button: String):
	inventory_items_container.show()
	if (toggledOn):
		if button == "weapon":
			weapon_btn.set_pressed(true)
			armor_btn.set_pressed(false)
			accessory_btn.set_pressed(false)
			weapon_container.show()
			armor_container.hide()
			acc_container.hide()
			populate_inventory(items_data)
		elif button == "armor":
			weapon_btn.set_pressed(false)
			armor_btn.set_pressed(true)
			accessory_btn.set_pressed(false)
			weapon_container.hide()
			armor_container.show()
			acc_container.hide()
			populate_inventory(items_data)
		elif button == "accessory":
			weapon_btn.set_pressed(false)
			armor_btn.set_pressed(false)
			accessory_btn.set_pressed(true)
			weapon_container.hide()
			armor_container.hide()
			acc_container.show()
			populate_inventory(items_data)
	else:
		remove_all_children(weapon_container.get_node("VBoxContainer"))
		remove_all_children(armor_container.get_node("VBoxContainer"))
		remove_all_children(acc_container.get_node("VBoxContainer"))
#loads item.json
func load_items():
	var file = FileAccess.open("res://Inventory/Items.json", FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var parse_result = json.parse(json_text)
		
		if parse_result == OK:
			items_data = json.get_data()
			populate_inventory(items_data)
		else:
			print("Failed to parse JSON", json.get_error_message())
	else:
		print("Failed to open file")
		
func populate_inventory(item_data):
	var container
	if weapon_btn.button_pressed == true:
		container = weapon_container.get_node("VBoxContainer")
		populate_container(item_data, container, "I_1")
	elif armor_btn.button_pressed == true:
		container = armor_container.get_node("VBoxContainer")
		populate_container(item_data, container, "I_4")
	elif accessory_btn.button_pressed == true:	
		container = acc_container.get_node("VBoxContainer")
		populate_container(item_data, container, "I_3")
			
func populate_container(items_data, item_container: Node, item_code: String):
	#Iterate over each item in dictionary
	for key in items_data.keys():
		if str(key).begins_with(item_code):
			var item = items_data[key]
			var slot_instance = slot_scene.instantiate()
			var button_label = slot_instance.get_node("Button")
		
			if item.has("Item"):
				button_label.text = item["Item"]
			else:
				button_label.text = "Unknown"
			item_container.add_child(slot_instance, true)
		else:
			pass
			
func remove_all_children(node: Node):
	# Iterate through all children of the node
	while node.get_child_count() > 0:
		var child = node.get_child(0)  # Get the first child
		node.remove_child(child)  # Remove the child from the parent
		child.queue_free()  # Free the child node from memory
