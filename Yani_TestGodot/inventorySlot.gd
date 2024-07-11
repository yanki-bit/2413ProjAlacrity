extends PanelContainer

#this is how you write comments
#coded by Yani ^ w ^ 

@onready var texture_rect = $TextureRect

#note: the three functions below are godot built-in
#return texture_rect as drag data
func _get_drag_data(at_position):
	return texture_rect
 
#check if the data from _get_drag_Data can be dropped
func _can_drop_data(_pos, data):
	return data is TextureRect

#swap the texture with drag data if it is droppable
func _drop_data(at_position, data):
	var temp = texture_rect.texture
	texture_rect.texture = data.texture
	data.texture = temp
