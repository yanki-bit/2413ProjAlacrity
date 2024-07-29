extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func on_exit_settings_pressed() -> void:
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_dictionary_store())
	print("This works")
	
func _unhandled_key_input(_event : InputEvent):
	if Input.is_action_just_pressed("pause"):
		on_exit_settings_pressed()
