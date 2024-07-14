class_name SettingsMenu

extends Control

@onready var exit_settings = $MarginContainer/VBoxContainer/Exit_Settings as Button

#Signal to exit settings and save changes
signal exit_settings_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	exit_settings.button_down.connect(on_exit_settings_pressed)
	set_process(false)
	
func on_exit_settings_pressed() -> void:
	exit_settings_menu.emit()
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_dictionary_store())
	set_process(false)

