class_name Player_Menu
extends Camera2D
#Camera fixed on the player visible when the user pauses and allows the user to select the menu options they desire

#All Weapons avaliable in the game
@onready  var WeaponList : MasterInventoryResource = preload("res://Resources/Items/MasterInventoryResource.tres")


@onready var player_menu = $"."
#this node needs to be direct child of player scene
@onready var player = $"../.."

#Player_menu buttons main
@onready var id_btn = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Menu_BG/MarginContainer/Player_Menu_Btn_Clstr/ID_btn as Button
@onready var equipment_btn = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Menu_BG/MarginContainer/Player_Menu_Btn_Clstr/Equipment_btn as Button
@onready var item_btn = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Menu_BG/MarginContainer/Player_Menu_Btn_Clstr/Item_btn as Button
@onready var ability_btn = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Menu_BG/MarginContainer/Player_Menu_Btn_Clstr/Ability_btn as Button
@onready var settings = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Menu_BG/MarginContainer/Player_Menu_Btn_Clstr/Settings as Button
@onready var exit = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Menu_BG/MarginContainer/Player_Menu_Btn_Clstr/Exit as Button

@onready var margin_container = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container/Inventory_Container/Panel/MarginContainer

@onready var information_container = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container
@onready var exit_confirmation_dialog = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container/Exit_ConfirmationDialog as ConfirmationDialog

@onready var inventory_container = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container/Inventory_Container
@onready var settings_tab_container = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container/Settings_tab_container

#pause state
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	id_btn.text =" "+PlayerInfo.player_name
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

#ready to use variables for inventory container
@onready var inventory_equipment = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container/Inventory_Container/Panel/MarginContainer/Inventory_Equipment
@onready var inventory_items = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container/Inventory_Container/Panel/MarginContainer/Inventory_Items

#for Inventory container, If the container is visible, hide children of margin, set target menu to be visible
func show_sub_menu(container: Node, subContainer: Node, target: Node) -> void:
	if container.visible:
		on_button_press(subContainer)
		target.visible = true
	else:
		container.visible = true
		on_button_press(subContainer)
		target.visible = true
#function when equipment button is pressed
func on_equipment_button_press() -> void:
	on_button_press(information_container)
	show_sub_menu(inventory_container, margin_container, inventory_equipment)

#opens player stats menu
func on_id_button_press() -> void:
	on_button_press(information_container)
	#show_sub_menu(inventory_container, margin_container, player_stats_card)
#opens ability list
func on_ability_button_press() -> void:
	on_button_press(information_container)
	#show_sub_menu(inventory_container, margin_container, inventory_ability
	
#opens consumable item list
func on_item_button_press() -> void:
	on_button_press(information_container)
	show_sub_menu(inventory_container, margin_container, inventory_items)
		
#opens settings menu
func on_settings_button_press() -> void:
	on_button_press(information_container)
	settings_tab_container.visible =!settings_tab_container.visible

#Give the player a pop up to confirm if they want to quit the game
func on_exit_button_press() -> void:
	on_button_press(information_container)
	exit_confirmation_dialog.popup_centered()
	
#hides direct child of container when button pressed
func on_button_press(container: Node) -> void:
	for child in container.get_children():
		if child is Node:
			child.visible = false

#Exits game Upon confirmation
func on_exit_confirmed():
	get_tree().quit()



