extends Sprite2D


# Add an export var ID
@export var ID = "0"

# on ready load the texture with ID 
func _ready():
	texture = load("res://art/objects/" + ItemData.get_texture(ID))

#if player enters, add an item to inventory and free it 
func _on_body_entered(body):
	get_parent().find_child("PlayerInventory").add_item(ID)
	queue_free()
