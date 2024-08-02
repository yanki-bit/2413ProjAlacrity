extends Resource
class_name PlayerData

#put all the stuff we wanna save
@export var health = 20
@export var name = PlayerInfo.player_name
@export var day = 1 

#this updates kind of constantly?
@export var SavePos: Vector2 #for player position in room

func UpdatePos(value: Vector2):
	SavePos = value
