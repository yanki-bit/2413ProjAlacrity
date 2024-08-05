
class_name MainMenu
extends Control
#Prepares UI buttons as variables
@onready var start = $Menu_Options/Options_Margin/HBoxContainer/VBoxContainer/START as Button
@onready var  load_game = $Menu_Options/Options_Margin/HBoxContainer/VBoxContainer/LOAD as Button
@onready var  setting = $Menu_Options/Options_Margin/HBoxContainer/VBoxContainer/SETTINGS as Button
@onready var  exit = $Menu_Options/Options_Margin/HBoxContainer/VBoxContainer/EXIT as Button

@onready var menu_options = $Menu_Options as TextureRect

#Settings Menu Scene
@onready var settings_menu = $Settings_Menu as SettingsMenu

#preloads the level start scene
@onready var start_scene = preload("res://Scenes/Intro/Intro.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connect_signal()

#Loads in the level start scene
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_scene)

#Exits the application
func on_exit_pressed() -> void:
	get_tree().quit()
	
#Allows users to edit game settings
func on_setting_pressed() -> void:
	menu_options.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true

#Toggles which menu is visible at a given time
func on_exit_settings()->void:
	menu_options.visible = true
	settings_menu.visible = false
	
#Handles behaviour when specified button is pressed
func handle_connect_signal()->void:
	start.button_down.connect(on_start_pressed)
	exit.button_down.connect(on_exit_pressed)
	setting.button_down.connect(on_setting_pressed)
	settings_menu.exit_settings_menu.connect(on_exit_settings)


## VARS FOR THE LOAD FUNC
@onready var Player = "res://Scripts/player.gd"
@onready var Scene = SceneManager.new() #"res://Game/SceneManager.gd"
@onready var Bed = preload("res://Scenes/School/bedroom.tscn")
@onready var load_scene = preload("res://Game/scene_manager.tscn") as PackedScene

## connected to the load button via node signal
func _on_load_pressed():
	SaveManager.load_player_data()
	#PlayerInfo.state["Bedroom"] = true #so it doesn't play intro dialogue
	get_tree().change_scene_to_packed(load_scene)
	
