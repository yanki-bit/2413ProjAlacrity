extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

#resolution options
const RESOLUTION_DICTIONARY: Dictionary = {
	"1080 x 720" : Vector2i(1080, 720),
	"1280 x 720" : Vector2i(1280, 720),
	"1920 x 1080" : Vector2i(1920,1080)
}

func _ready():
	option_button.item_selected.connect(on_resolution_selected)
	add_resolution_items()
	
#handles change resolution. use this for save files later
func on_resolution_selected(index : int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
	center_window()
	
#adds the text to the dropdown	
func add_resolution_items() -> void:
	for resolution_size in RESOLUTION_DICTIONARY:
		option_button.add_item(resolution_size)

#Centers window
func center_window():
	var center_screen = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(center_screen - window_size/2)
