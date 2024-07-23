@tool #helps change the icons in real time
extends Node2D

#coded by yankidoodle
#define the item properties, using @export exposes these variables to godot editor
@export var item_type = "" #is it consumable etc.
@export var item_name = ""
@export var item_ATK = ""
@export var item_texture: Texture

# static var that shouldn't change 
# helps load items for spawning
var scene_path = "res://inventory/test_pinventory/inventory_item.tscn"

# scene tree node references
# make sure it loads the item icon
@onready var icon_sprite = $item_icon

#variables
var player_in_range = false # detects item and player interaction range


# Called when the node enters the scene tree for the first time.
func _ready():
	#
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#sets texture in editor
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture
	#add item to inventory if player presses a button in range
	if player_in_range and Input.is_action_just_pressed("interact"):
		pickup_item()
	
#picking up items
func pickup_item():
	#create an item dictionary
	var item = {
		"quantity": 1,
		"item_type": item_type,
		"item_name": item_name,
		"item_texture": item_texture,
		"scne_path": scene_path,
	}
	# check the global script
	if GlobalPinventory.player_node:
		GlobalPinventory.add_item(item)
		self.queue_free()
		
		
#if player is in range of the item, show ui and make the item pickable
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true
		#reference the ui_interact child node in the player body
		body.ui_interact.visible = true
		
func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false
		body.ui_interact.visible = false
