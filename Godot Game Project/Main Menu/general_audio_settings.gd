extends Control
@onready var audio_label = $HBoxContainer/Audio_Label as Label
@onready var h_slider = $HBoxContainer/HSlider as HSlider

#name of audio buses
@export_enum("Master", "BGM", "SoundFX") var bus_name : String

var bus_index : int = 0

func _ready():
	h_slider.value_changed.connect(on_value_changed)
	get_bus_name_index()
	set_audio_text()
	set_slider_value()
	
#function to change value of label
func set_audio_text() -> void:
	audio_label.text = str(bus_name) + " Volume"
	
#behaviour when audio value changed through slider
func on_value_changed(value : float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	
func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	
#grabs indexed name for audio buses
func get_bus_name_index() -> void:
	bus_index = AudioServer. get_bus_index(bus_name)
