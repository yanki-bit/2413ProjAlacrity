extends Control

#scene tree node references
@onready var quantity = $ColorRect/itemQty
@onready var item_name = $ColorRect/itemName
@onready var popup_item_name = $DetailsPanel/ItemName
@onready var item_type = $ColorRect/itemType
@onready var item_blurb = $DetailsPanel/ItemBlurb
@onready var details_panel = $DetailsPanel
@onready var usage_panel = $UsagePanel
@onready var usage_panel2 = $UsagePanel2
@onready var slot_empty = $EmptyPanel


# slot item
var item = null

func _on_item_button_mouse_exited():
	details_panel.visible = false


func _on_item_button_mouse_entered():
	if item != null:
		slot_empty.visible = false
		usage_panel.visible = false
		details_panel.visible = true

#show item options if there items 
func _on_item_button_pressed():
	if item != null:
		usage_panel.visible = !usage_panel.visible
		#slot_empty.visible = false

# le default empty slot 
func set_empty():
	quantity = null
	#slot_empty.visible = true
	
# set slot item with values from the dictionary 
# make sure it matches with the inventory_item script
func set_item(new_item):
	item = new_item
	item_name.text = str((item["item_name"]))
	item_type.text = str ((item["item_type"]))
	quantity.text = str((item["quantity"]))
	item_blurb.text = str((item["item_blurb"]))
