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
	#check what the status of the menu is
	match menu_status:
		#if menu is currently closed
		menuState.CLOSED:
			if event.is_action_pressed("pause"):
				#obtain reference to player node
				var player = find_parent("Player")
				#pause physics to stop movement
				player.set_physics_process(false)
				player_menu.show()
				#set menu state to pause
				menu_status = menuState.PAUSE_MENU
				#set focus to first menu option
				$"Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/ID Card".grab_focus()
				
		#if menu is currently open
		menuState.PAUSE_MENU:
			if event.is_action_pressed("pause"):
				#obtain reference to player node
				var player = find_parent("Player")
				#restart physics to restart movement
				player.set_physics_process(true)
				player_menu.hide()
				#set menu state to closed
				menu_status = menuState.CLOSED
	# recieve pause input
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass




