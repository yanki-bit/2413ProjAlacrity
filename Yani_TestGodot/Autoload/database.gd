extends Node

# ################################################################################################
# programmer: Yani
# desc: This script is to load the JSON file items database 
# usage: Script is added to autoload as a default, go to Project > Project Settings > Autoload
##################################################################################################

# declare a dictionary var called content
var content : Dictionary 

#open the sampleitems json file and store the data in the content var
func _ready(): 
	var file = FileAccess.open("res://Autoload/sampleitems.json", FileAccess.READ)
	
	content = JSON.parse_string(file.get_as_text())
	
	file.close()

# get the default state numbers/item files from the sample items
func get_texture(ID = "0"):
	return content[ID]["texture"]
	

#get the default attack stat values from the sample items
func get_ATK(ID = "0"):
	return content[ID]["ATK"]
	

#get the default slot type of the item
func get_slot_type(ID = "0"):
	return content[ID]["slot_type"]

# after setting up this script, enable it to be autoloaded in Project > Project Settings > Autoload > Add Script
# rename the script as "Item Data" and press add, then you can access these values from any node 
