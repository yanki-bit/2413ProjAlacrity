extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

#Options available
const WINDOW_ARRAY : Array[String] = [
	"Windowed", #0
	"Full-Screen", #1
	"Borderless Windowed", #2
	"Borderless Full-Screen" #3
]

func _ready():
	#When item selected from dropdown, selects specifically that value
	add_window_mode_items()
	option_button.item_selected.connect(on_window_selected)
	load_data()
	
func load_data() -> void:
	on_window_selected(SettingsDataContainer.get_window_index())
	option_button.select(SettingsDataContainer.get_window_index())
	
#adds more options
func add_window_mode_items() -> void:
	for window_mode in WINDOW_ARRAY:
		option_button.add_item(window_mode)

func on_window_selected(index : int) -> void:
	SettingsSignalBus.emit_on_window_mode_selected(index)
	#match index value for window array
	match index:
		0: #Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		1: #Full-Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		2:#Borderless Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
		3:#Borderless Full-Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
