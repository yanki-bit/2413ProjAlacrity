extends Control

# ################################################################################################
# programmer: Yani
# desc: This script is attached to the Control Scene for Item Popups
# usage: Script is added to autoload as a default, go to Project > Project Settings > Autoload
##################################################################################################

# Create a function using the built in popup() function
# target the %ItemPopup popup panel node
# get the data as a parameter value for ItemPopup
func ItemPopup(slot : Rect2i, item : Item): #data is used in the inventorySlot script
	if item != null:
		set_value(item) #set values before showing the popup
		%ItemPopup.size = Vector2i.ZERO #removes extra space for long name weapon items
	
	#get mouse position relative to viewport and store it in mouse_pos
	var mouse_pos = get_viewport().get_mouse_position()
	var correction
	#add padding value
	var padding = 4
	
	#if mouse is at left half of the screen set correction to +slot size.x
	if mouse_pos.x <= get_viewport_rect().size.x/2:
		correction = Vector2i(slot.size.x + padding, 0)
	else: #if its on the right half, set correction to -Popup.size.x
		correction = -Vector2i(%ItemPopup.size.x + padding, 0)
	
	#set the popup position to slot.position + correction
	%ItemPopup.popup(Rect2i( slot.position + correction, %ItemPopup.size ))

# function to hide the popup
func HideItemPopup():
	%ItemPopup.hide()
	

#set item properties according to the text labels for every item with the Item resource class
# convert to text for integer stats
func set_value(item : Item): 
	%Name.text = item.name
	%"Item Info".text = item.desc
	%"Item Type".text = item.attribute_type
	%"Item Price".text = str(item.price)
	%"Item HP".text = str(item.item_HP)
	%"Item ATK".text = str(item.item_ATK)
	%"Item DEF".text = str(item.item_DEF)
	%"Item SPD".text = str(item.item_SPD)
	%"Item LCK".text = str(item.item_LCK)

