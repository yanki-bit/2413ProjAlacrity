extends Node

#variables 
@export var inventory = [ createCurrentInventoryItem("Ball", "res://inventory/pkmn_inventory/tile016.png", "a small ball", 0)]

func createCreateInventoryItem(_Name, _Sprite, _Description, _ID):
	return {
		Name = _Name,
		ItemSprite = _Sprite,
		Description = _Description, 
		ID = _ID
		
	}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
