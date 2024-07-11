extends Slot
class_name PassiveSlot

# override the function from Slot class and check slot type 
func _can_drop_data(_pos, data):
	return data is TextureRect and data.slot_type == slot_type
