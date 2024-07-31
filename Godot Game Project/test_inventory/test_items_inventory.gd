extends Control

var template_inv_slot = preload("res://test_inventory/test_items.tscn")

onready var gridcontainer = get_node("Background/MarginContainer/VBoxContainer/ScrollCotainer/GridContainer")

func _ready():
	var inv_slot_new = template_inv_slot.instance()
	if PlayerData.inv_data[i]["item"] !=null:
		var item_name = GameData.item_data[str(PlayerData.inv_data[i]["Item"])]["Name"]
		inv_slot_new.get_node("node").set_texture(icon_texture)
		gridcontainer.add_child(inv_slot_new, tru)
