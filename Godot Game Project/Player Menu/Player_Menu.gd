class_name PlayerMenu
extends Control
# create enum that tracks the status of the menu. use to figure out which menu layer to display 
enum menuState { CLOSED, PAUSE_MENU }
var menu_status = menuState.CLOSED
@onready var player_menu = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#recieve input
func _unhandled_input(event):
	match menu_status:
		menuState.CLOSED:
			if event.is_action_pressed("pause"):
				player_menu.show()
				menu_status = menuState.PAUSE_MENU
		
		menuState.PAUSE_MENU:
			if event.is_action_pressed("pause"):
				player_menu.hide()
				menu_status = menuState.CLOSED
	# recieve pause input
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass




