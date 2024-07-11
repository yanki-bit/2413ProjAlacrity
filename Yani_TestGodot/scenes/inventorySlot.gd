extends PanelContainer
#add a class name
class_name Slot

#this is how you write comments
#coded by Yani ^ w ^ 

@onready var texture_rect = $TextureRect

#add export_enum and variable slot_type
@export_enum("NONE:0","HEAD:1", "BODY:2","LEG:3","ACTIVE:4") var slot_type : int


#boolean for checking if a slot is filled and initialize to false
var filled : bool = false


#return texture_rect as drag data
func _get_drag_data(at_position):
	
	#set the drag preview
	set_drag_preview(get_preview())
	
	return texture_rect
 
#check if the data from _get_drag_Data can be dropped
func _can_drop_data(_pos, data):
	return data is TextureRect

#swap the texture with drag data if it is droppable
func _drop_data(at_position, data):
	var temp = texture_rect.property
	texture_rect.property = data.property
	data.property = temp

#create a preview for the drag and drop function
# create a new instance of TextureRect

func get_preview():
	var preview_texture = TextureRect.new()
	
	#set properties
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30) #this is the size of the preview 
	
	#make a new instance of Control and add in the preview texture
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	return preview

#return atk using get_atk
func get_ATK():
	return texture_rect.ATK

#define set_property function
func set_property(data):
	texture_rect.property = data 
	
	#check if the texture is null or not to make it filled
	if data["TEXTURE"] == null:
		filled = false
	else:
		filled = true
