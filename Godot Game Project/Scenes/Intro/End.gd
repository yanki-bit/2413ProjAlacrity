extends Control

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String
const BALLOON = preload("res://Scenes/Intro/Credit_balloon.tscn")
var balloon: Node = BALLOON.instantiate()

func _ready():
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)

