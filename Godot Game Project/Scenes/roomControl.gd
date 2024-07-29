extends CanvasLayer

# in relation to inventory gui
@onready var inventory = $InventoryGui

#make sure the inventory is closed by default
# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.close()

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()

