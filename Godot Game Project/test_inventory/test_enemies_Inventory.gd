extends Control

# Preload the InventorySlot scene
var slot_scene = preload("res://test_inventory/EnemiesInventorySlot3.tscn")


@onready var gridcontainer = get_node("Background/MarginContainer/VBoxContainer/ScrollContainer/GridContainer")

func _ready():
	# Load JSON file
	var file = FileAccess.open("res://test_inventory/EnemiesJson.json", FileAccess.READ)
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
		
		var label = slot_instance.get_node("Label")
	
	 
		if item.has("Name"):
			label.text = item["Name"]
		else:
			label.text = "Unknown Name"


		# Add the slot instance to the GridContainer
		grid_container.add_child(slot_instance, true)

