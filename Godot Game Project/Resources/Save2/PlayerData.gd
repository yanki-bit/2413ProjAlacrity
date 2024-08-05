extends Resource
class_name PlayerData


#put all the stuff we wanna save
@export var health = 20
@export var name = PlayerInfo.player_name
@export var day = PlayerInfo.day
@export var state: Dictionary = PlayerInfo.state #calls the dictionary

#this updates kind of constantly?
@export var SavePos: Vector2 #for player position in room

func UpdatePos(value: Vector2):
	SavePos = value

func UpdateState():
	state = PlayerInfo.state

##customized keys
#func create_keybind_dict() -> Dictionary:
	#var keybinds_container_dict = {
		#keybind_resource.MOVE_LEFT : keybind_resource.move_left_key,
		#keybind_resource.MOVE_RIGHT : keybind_resource.move_right_key,
		#keybind_resource.MOVE_UP : keybind_resource.move_up_key,
		#keybind_resource.MOVE_DOWN : keybind_resource.move_down_key,
		#keybind_resource.INTERACT : keybind_resource.interact_key
	#}
	#return keybinds_container_dict

func _ready():
	setName()
	#setState()

func setName():
	name = PlayerInfo.player_name
	
#func setState() -> Dictionary:
#	var player_State = {
#		state[] player_Info.state[]
#	}
