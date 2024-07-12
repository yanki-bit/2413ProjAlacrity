# ################################################################################################
# programmer: Yani
# desc: This script portion below is related to the Item Tooltip Popup Window; 
# currently not attached to any node 
# usage: After finishing the script go to Inspector tab and create new resource with the Item script
##################################################################################################

extends Resource
class_name Item #in relation to the popup

@export_category("Information")
@export var name : String #item name
@export var attribute_type : String #item type
@export var price : int #item price
@export var desc : String #item description
@export var texture : Texture2D #item icon / photo 

@export_category("Stats")
@export var item_HP : int #item stat for health
@export var item_ATK : int #item stat for attack
@export var item_DEF : int #item stat for defense
@export var item_SPD : int #item stat for speed
@export var item_LCK : int #item stat for Luck
