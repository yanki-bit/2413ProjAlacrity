extends Control

# Preload the InventorySlot scene
var slot_scene = preload("res://test_inventory/AbilitiesInventorySlot3.tscn")


@onready var gridcontainer = get_node("Background/MarginContainer/VBoxContainer/ScrollContainer/GridContainer")

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
	var grid_container = $Background/MarginContainer/VBoxContainer/ScrollContainer/GridContainer # Ensure this matches the actual node name

#iterate over each item in the dictionary
	for key in items_data.keys():
		var item = items_data[key]
		
		var slot_instance = slot_scene.instantiate()
		#var texture_rect = slot_instance.get_node("inv1")
		var label = slot_instance.get_node("Label")
		# Optionally, set the item texture (if you have icons, otherwise this can be empty)
	 
		if item.has("Ability"):
			label.text = item["Ability"]
		else:
			label.text = "Unknown Ability"
	#		var item_texture = preload(item_data.items)  # Path to the texture
		#texture_rect.texture = item_texture
		#var texture_path = item.get("icon", null)
		#if texture_path:
		#	var item_texture = load(texture_path)
		#	texture_rect.texture = item_texture
		#else:
		#	texture_rect.texture = placeholder_texture
		# Set the item name
		#label.text = item.name

		# Ensure the Label is on top of the TextureRect
		# This is managed in the scene tree by node hierarchy

		# Add the slot instance to the GridContainer
		grid_container.add_child(slot_instance, true)
