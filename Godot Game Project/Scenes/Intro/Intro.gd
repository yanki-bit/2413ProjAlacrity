extends Control
class_name IntroScene
@export var dialogue_resource: DialogueResource
const BALLOON = preload("res://Dialogue/balloon.tscn")
var player_name
# Called when the node enters the scene tree for the first time.
var balloon: Node = BALLOON.instantiate()
@onready var line_edit = $Panel/LineEdit as LineEdit
@onready var submit = $Panel/Submit as Button
@onready var start_scene = preload("res://Game/scene_manager.tscn") as PackedScene

var dialogue_line
signal next_dialog()

func _ready():
	line_edit.hide()
	submit.hide()
	next_dialog.connect(enter_name)
	
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, "Intro")
	line_edit.text_submitted.connect(_on_submit_pressed)


#function to get name from user
func dialogue_done()-> void:
	next_dialog.emit()

func enter_name() -> void:
	line_edit.show()
	submit.show()
	


func _on_submit_pressed():
	print()
	var input = line_edit.text.strip_edges()
	if input != "":
		player_name = input
		PlayerInfo.player_name = input
		get_tree().change_scene_to_packed(preload("res://Scenes/Intro/Intro2.tscn"))
