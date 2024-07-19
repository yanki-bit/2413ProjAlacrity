extends Control
#UI for inventory type weapon
@export var player_inventory_path: NodePath
@onready var weapon_item_list = $"./$MarginContainer"


var player_inventory

func _ready():
	# Get the player inventory node
	player_inventory = get_node(player_inventory_path)
	if player_inventory == null:
		print("Player inventory node not found!")
		return
	
	# Ensure weapon_list_container is valid
	if weapon_item_list == null:
		print("Weapon list container not found!")
		return
	
	# Populate the weapon list
	populate_weapon_list()

func populate_weapon_list():
	# Clear any existing children
	for child in weapon_item_list.get_children():
		child.queue_free()
	
	# Get the player's inventory items
	var inventory_items = player_inventory.get_inventory_items()
	
	# Iterate through the player's inventory and create a button for each
	for item_name in inventory_items:
		var item_details = player_inventory.get_item_details(item_name)
		
		# Create a button for each item
		var item_button = Button.new()
		item_button.text = item_details["name"] + " (ATK: " + str(item_details["atk"]) + ")"
		item_button.connect("pressed", Callable(self, "_on_item_button_pressed").bind(item_name))
		
		# Add the button to the VBoxContainer
		weapon_item_list.add_child(item_button)

func _on_item_button_pressed(item_name):
	var item_details = player_inventory.get_item_details(item_name)
	show_item_details(item_details)

func show_item_details(item):
	# Display item details in the UI
	print("Item Name: ", item["name"])
	print("Attack Power: ", item["atk"])
	print("Description: ", item["description"])
