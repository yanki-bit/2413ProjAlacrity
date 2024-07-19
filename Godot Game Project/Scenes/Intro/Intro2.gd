extends Control
@onready var start_scene = preload("res://Game/scene_manager.tscn") as PackedScene
@export var dialogue_resource: DialogueResource
const BALLOON = preload("res://Dialogue/balloon.tscn")
var balloon: Node = BALLOON.instantiate()


func _ready():
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, "name")

func next_scene() -> void:
	get_tree().change_scene_to_packed(start_scene)

