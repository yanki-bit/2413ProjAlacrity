extends TextureRect


# create a variable for the slot type
@export var slot_type: int = 0

# sample variable for attack damage and make it a setter variable
@export var ATK = 0:
	set(value):
		ATK = value
		#update ATK through atkCount
		%atkCount.text = str(ATK) 
		
		#call the calculateATK function for any change in ATK stat for Passive Inventory Slots
		if get_parent() is PassiveSlot:
			get_parent().get_parent().calculateATK()

#add a Dictionary Type variable
@onready var property: Dictionary = {
	# create properties for texture, attack and slot type
	"TEXTURE": texture,
	"ATK": ATK,
	"SLOT_TYPE": slot_type
}:
	set(value):
		property = value #convert to setter function
		
		#update the three properties from Dictionary type
		texture = property["TEXTURE"]
		ATK = property["ATK"]
		slot_type = property["SLOT_TYPE"]
