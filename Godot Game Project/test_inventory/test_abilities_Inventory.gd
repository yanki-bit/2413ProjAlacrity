extends Control

# Preload the InventorySlot scene
var slot_scene = preload("res://test_inventory/InventorySlot2.tscn")

func _ready():
	# Load JSON file
	var file = FileAccess.open("res://test_inventory/AbilitiesJson.json", FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var parse_result = json.parse(json_text)
		
		if parse_result == OK:
			var items_data = json.get_data()
			populate_inventory(items_data)
		else:
			print("Failed to parse JSON: ", json.get_error_message())
	else:
		print("Failed to open file")

func populate_inventory(items_data):
	var grid_container = $GridContainer  # Assuming GridContainer is named GridContainer

	# Ensure GridContainer is valid
	if grid_container:
		# Iterate through items data and instantiate slots
		for item in items_data.items:
			var slot_instance = slot_scene.instantiate()
			var label = slot_instance.get_node("Label")  # Assuming the Label node is named Label
			
			if label:
				# Set the label text to the item name
				label.text = item.name
			
				# Add the slot instance to the GridContainer
				grid_container.add_child(slot_instance)
			else:
				print("Label node not found in slot instance")
	else:
		print("GridContainer node not found")
