class_name HotKeyRebindBtn
extends Control
@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button

@export var action_name : String = "move_left"


# Called when the node enters the scene tree for the first time.
func _ready():
	#When a key is pressed and isnt being handling another action it will be picked up (true) otherwise do nothing (false)
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()
	
#sets the text for the labels	
func set_action_name() -> void:
	label.text = "Unassigned"
	#match statement for labels used in godot inspector
	match action_name:
		"move_left":
			label.text = "Move Left"
		"move_right":
			label.text = "Move Right"
		"move_up":
			label.text = "Move Up"
		"move_down":
			label.text = "Move Down"
		"interact":
			label.text = "Interact"

#sets the text for the button
func set_text_for_key() -> void:
	#filtering for key input
	var action_events = InputMap.action_get_events(action_name)
	if action_events.size() > 0:
		var action_event = action_events[0]
		var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
		button.text = "%s" % action_keycode
	else:
		button.text = "Unassigned"
	
func _on_button_toggled(button_pressed):
	if button_pressed:
		button.text = "Press any key . . ."
		set_process_unhandled_key_input(button_pressed)
		
		#iterates over each action_name to see what it currently is
		for i in get_tree().get_nodes_in_group("hotkey_button"): 
			if i.action_name != self.action_name: 
				i.button.toggle_mode = false #stops every other button from being toggled
				i.set_process_unhandled_key_input(false)
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"): 
			if i.action_name != self.action_name: 
				i.button.toggle_mode = true #stops every other button from being toggled
				i.set_process_unhandled_key_input(false)
		set_text_for_key()

#grabs specific key being used upon keyboard press
func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed = false
	
#actually rebinds the keys
func rebind_action_key(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
