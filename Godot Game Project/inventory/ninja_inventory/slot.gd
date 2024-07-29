extends Panel

@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item
@onready var item_name: RichTextLabel = $itemName
@onready var item_qty: Label = $itemCount

func update(item: InventoryItem):
	if !item:
		itemSprite.visible = false
		item_name.visible = false
		#item_qty.visible = false
	else:
		itemSprite.visible = true
		itemSprite.texture = item.texture
		item_name.visible = true
		item_name.text = item.name
		#item_qty.visible = true
		#item_qty = item.quantity

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
