class_name Player_Menu
extends Camera2D
#Camera fixed on the player visible when the user pauses and allows the user to select the menu options they desire

@onready var player_menu = $"."
@onready var player = $".."

@onready var id_btn = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/ID_btn as Button
@onready var equipment_btn = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/Equipment_btn as Button
@onready var item_btn = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/Item_btn as Button
@onready var ability_btn = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/Ability_btn as Button
@onready var settings = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/Settings as Button
@onready var exit = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/Exit as Button

@onready var information_container = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container
@onready var exit_confirmation_dialog = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container/Exit_ConfirmationDialog as ConfirmationDialog

@onready var inventory_container = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container/Inventory_Container
@onready var settings_tab_container = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container/Settings_tab_container

var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connect_signal()
	player_menu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu()

#function to show and hide the pause menu 
func pause_menu():
	if paused:
		player_menu.hide()
		player.set_physics_process(true) #resumes player movement
	else:
		player_menu.show()
		player.set_physics_process(false) #pauses player movement
	paused = !paused
	
#handles button events
func handle_connect_signal() -> void:
	equipment_btn.button_down.connect(on_equipment_button_press)
	id_btn.button_down.connect(on_id_button_press)
	item_btn.button_down.connect(on_item_button_press)
	ability_btn.button_down.connect(on_ability_button_press)
	settings.button_down.connect(on_settings_button_press)
	exit.button_down.connect(on_exit_button_press)

#function when equipment button is pressed
func on_equipment_button_press() -> void:
	on_button_press(information_container)
	inventory_container.visible = !inventory_container.visible
	$Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container/Inventory_Container/Panel/MarginContainer/Inventory_Equipment.visible = !$Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container/Inventory_Container/Panel/MarginContainer/Inventory_Equipment.visible
	
func on_id_button_press() -> void:
	pass
func on_ability_button_press() -> void:
	pass
func on_item_button_press() -> void:
	pass
func on_settings_button_press() -> void:
	on_button_press(information_container)
	settings_tab_container.visible =!settings_tab_container.visible

func on_exit_button_press() -> void:
	on_button_press(information_container)
	exit_confirmation_dialog.popup_centered()
	
#hides all children of container when button pressed
func on_button_press(container: Node) -> void:
	for child in container.get_children():
		if child is Node:
			child.visible = false

#Exits game Upon confirmation
func on_exit_confirmed():
	get_tree().exit()

