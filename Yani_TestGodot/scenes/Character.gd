extends Control


# Called when the node enters the scene tree for the first time.
@onready var atk = %ATK

#calculate to get the sum of the attack stat in each passive inventory slot
func calculateATK():
	var sum = 0
	
	for i in get_children():
		sum += i.get_ATK() #get atk is defined in the inventorySlot script
		
	atk.text = str(sum)
