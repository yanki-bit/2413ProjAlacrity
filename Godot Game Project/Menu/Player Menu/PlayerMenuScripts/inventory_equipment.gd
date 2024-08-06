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

signal item_clicked(text) 

# enum containing all possible states of the equipment screen 
enum MENU_STATES {
	NOTHING,
	WEAPON,
	ACCESSORY,
	ARMOR
}

var current_state # store what items are currently being shown
func _ready():
	_handle_button_toggled(true,"weapon")
	
func hover_disconnect():
	%Description_display.hide()
	
func hover_connect(text):
	%Description_display.show()
	for key in Items.databaseItems.keys():
		var item = Items.databaseItems[key]
		if item.Item == text:
			$"../../../../../../Description_display/MarginContainer/ItemDescription/Description".text = "Description: " + item.Description + "\n"
			for ki in item.Stat.keys():
				$"../../../../../../Description_display/MarginContainer/ItemDescription/Description".text += String(ki)+ ": " + str(item.Stat[ki]) + "\n"

func clicked(text):
	# show the other items in the list as unequipped 
	match current_state:
		MENU_STATES.WEAPON:
			for child in weapon_container.get_node("VBoxContainer").get_children():
				if child.button.text == text:
					child.label.text = "Equipped"
				else:
					child.label.text = " "
		MENU_STATES.ACCESSORY:
			for child in acc_container.get_node("VBoxContainer").get_children():
				if child.button.text == text:
					child.label.text = "Equipped"
				else:
					child.label.text = " "
		MENU_STATES.ARMOR:
			for child in armor_container.get_node("VBoxContainer").get_children():
				if child.button.text == text:
					child.label.text = "Equipped"
				else:
					child.label.text = " "
	emit_signal("item_clicked", text)

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
			populate_inventory(Items.databaseItems)
			for child in weapon_container.get_node("VBoxContainer").get_children():
				# connect inventory slot signals
				child.connect("hover", Callable(self, "hover_connect"))
				child.connect("hover_exit", Callable(self, "hover_disconnect"))
				child.connect("click", Callable(self, "clicked"))
				
				# check if player has an item of this type equipped and show if it its
				if PlayerInfo.equipped_weapon.size() > 0:
					if child.button.text == PlayerInfo.equipped_weapon.Item:
						child.label.text = "Equipped"
					else:
						child.label.text = " "
				else:
					child.label.text = " "
				
			current_state = MENU_STATES.WEAPON
			
		elif button == "armor":
			weapon_btn.set_pressed(false)
			armor_btn.set_pressed(true)
			accessory_btn.set_pressed(false)
			weapon_container.hide()
			armor_container.show()
			acc_container.hide()
			populate_inventory(Items.databaseItems)
			for child in armor_container.get_node("VBoxContainer").get_children():
				child.connect("hover", Callable(self, "hover_connect"))
				child.connect("hover_exit", Callable(self, "hover_disconnect"))
				child.connect("click", Callable(self, "clicked"))
				
				# check if player has an item of this type equipped and show if it its
				if PlayerInfo.equipped_armor.size() > 0:
					if child.button.text == PlayerInfo.equipped_armor.Item:
						child.label.text = "Equipped"
					else:
						child.label.text = " "
				else:
					child.label.text = " "
			current_state = MENU_STATES.ARMOR

		elif button == "accessory":
			weapon_btn.set_pressed(false)
			armor_btn.set_pressed(false)
			accessory_btn.set_pressed(true)
			weapon_container.hide()
			armor_container.hide()
			acc_container.show()
			populate_inventory(Items.databaseItems)
			for child in acc_container.get_node("VBoxContainer").get_children():
				child.connect("hover", Callable(self, "hover_connect"))
				child.connect("hover_exit", Callable(self, "hover_disconnect"))
				child.connect("click", Callable(self, "clicked"))
				
				# check if player has an item of this type equipped and show if it its
				if PlayerInfo.equipped_accessory.size() > 0:
					if child.button.text == PlayerInfo.equipped_accessory.Item:
						child.label.text = "Equipped"
					else:
						child.label.text = " "
				else:
					child.label.text = " "
			current_state = MENU_STATES.ACCESSORY
	else:
		remove_all_children(weapon_container.get_node("VBoxContainer"))
		remove_all_children(armor_container.get_node("VBoxContainer"))
		remove_all_children(acc_container.get_node("VBoxContainer"))
		current_state = MENU_STATES.NOTHING

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
