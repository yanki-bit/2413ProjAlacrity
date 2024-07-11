extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

#Options available
const WINDOW_ARRAY : Array[String] = [
	"Full-Screen", #0
	"Windowed", #1
	"Borderless Windowed", #2
	"Borderless Full-Screen" #3
]

func _ready():
	#When item selected from dropdown, selects specifically that value
	add_window_mode_items()
	option_button.item_selected.connect(on_window_selected)
	
#adds more options
func add_window_mode_items() -> void:
	for window_mode in WINDOW_ARRAY:
		option_button.add_item(window_mode)

func on_window_selected(index : int) -> void:
	#match index value for window array
	match index:
		0: #Full-Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		1: #Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		2:#Borderless Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
		3:#Borderless Full-Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
