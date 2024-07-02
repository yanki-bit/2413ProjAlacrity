class_name MainMenu
extends Control

@onready var start = $Menu_Options/Options_Margin/HBoxContainer/VBoxContainer/START as Button
@onready var  load_game = $Menu_Options/Options_Margin/HBoxContainer/VBoxContainer/LOAD as Button
@onready var  setting = $Menu_Options/Options_Margin/HBoxContainer/VBoxContainer/SETTINGS as Button
@onready var  exit = $Menu_Options/Options_Margin/HBoxContainer/VBoxContainer/EXIT as Button

@onready var start_level = preload("res://Scenes/room.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	start.button_down.connect(on_start_pressed)
	exit.button_down.connect(on_exit_pressed)
	
func on_start_pressed() -> void:
	pass
	
func on_exit_pressed() -> void:
	get_tree().quit()
