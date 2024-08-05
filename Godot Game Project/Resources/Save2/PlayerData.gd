extends Resource
class_name PlayerData


#put all the stuff we wanna save
@export var health = 20
@export var name = PlayerInfo.player_name
@export var day = PlayerInfo.day
@export var state: Dictionary = PlayerInfo.state #calls the dictionary

##Defaults



