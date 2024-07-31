extends Node


var items

func _ready():
	_read() 

func _read():
	items = read_from_JSON("res://inventory/test_save/itemsInventory.json")
	if items:
		for key in items.keys():
			items[key]["key"] = key
		
func read_from_JSON(path: String) -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ)
	var data ={}
	
	if file:
		var json_data = file.get_as_text()  # Get the file content as a string
		file.close()
		
		var json = JSON.new()  # Create a new JSON instance
		var parse_result = json.parse(json_data)  # Parse the JSON string
		
		if parse_result == OK:  # Check if parsing succeeded
			data = json.get_data()  # Retrieve the parsed data
	
		else:
			push_error("Failed to parse JSON data: %s" % json.get_error_message())
			
	else: 
		push_error("Failed to open file at path: %s" % path)
	return data		
func get_item_by_key(key: String) -> Variant:
			if items and items.has(key):
				return items[key].duplicate(true)
			
			return null
