extends GridContainer

func _ready():
	add_item() #for testing purposes
	add_item("1")
	add_item("2")
	add_item("3")
	add_item("4")

# get texture, slot type and attack stat then store it in dictionary
func add_item(ID = "0"):
	var item_texture = load("res://art/objects/" + ItemData.get_texture(ID))
	var item_slot_type = ItemData.get_slot_type(ID)
	var item_ATK = ItemData.get_ATK(ID)
	
	var item_data = {
		"TEXTURE": item_texture,
		"ATK": item_ATK,
		"SLOT_TYPE": item_slot_type
	}
	
	#call set property function by passing data for the first slot
	#get_child(0).set_property(item_data)
	
	#traverse through all the slots to check if there is an item or not 
	var index = 0
	for i in get_children():
		if i.filled == false:
			index = i.get_index() #gets index of first unfilled slot
			break
	get_child(index).set_property(item_data) #add an item to that unfilled slot index
