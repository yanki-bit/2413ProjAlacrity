extends Control

var slot_scene = preload("res://Menu/Player Menu/inventory_slot.tscn")
@onready var v_box_container = $VBoxContainer/Inventory_Items_Container/MarginContainer/Item_List_Container/VBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	#load_items()
	populate_inventory(Items.databaseItems)

	for child in v_box_container.get_children():
		child.connect("hover", Callable(self, "hover_connect"))
		child.connect("hover_exit", Callable(self, "hover_disconnect"))
		
func hover_disconnect(text):
	%Description_display.hide()
	
func hover_connect(text):
	%Description_display.show()
	for key in Items.databaseItems.keys():
		if str(key).begins_with("I_2"):
			var item = Items.databaseItems[key]
			if item.Item == text:
				$"../../../../../../Description_display/MarginContainer/ItemDescription/Description".text = "Description: " + item.Description
#loads item.json
#func load_items():
	#var file = FileAccess.open("res://Inventory/Items.json", FileAccess.READ)
	#if file:
		#var json_text = file.get_as_text()
		#file.close()
		#
		#var json = JSON.new()
		#var parse_result = json.parse(json_text)
		#
		#if parse_result == OK:
			#var items_data = json.get_data()
			#populate_inventory(items_data)
		#else:
			#print("Failed to parse JSON", json.get_error_message())
	#else:
		#print("Failed to open file")
		
func populate_inventory(items_data):
	var item_container = $VBoxContainer/Inventory_Items_Container/MarginContainer/Item_List_Container/VBoxContainer
	
	#Iterate over each item in dictionary
	for key in items_data.keys():
		if str(key).begins_with("I_2"):
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


func _on_inventory_slot_mouse_entered():
	print("test works")
