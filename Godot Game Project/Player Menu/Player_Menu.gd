class_name PlayerMenu
extends Camera2D
#Camera fixed on the player visible when the user pauses and allows the user to select the menu options they desire

@onready var player_menu = $"."
@onready var player = $".."

@onready var id_btn = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/ID_btn as Button
@onready var equipment_btn = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/Equipment_btn as Button
@onready var item_button = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/Item_button as Button
@onready var ability_btn = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/Ability_btn as Button
@onready var settings = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/Settings as Button
@onready var exit = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Panel/MarginContainer/Player_Menu_Btn_Clstr/Exit as Button

@onready var inventory_container = $Menu_Margin/Player_Menu_Container/Player_Data_Container/Information_Container/Inventory_Container

var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connect_signal()
	player_menu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu()

#function to show and hide the pause menu 
func pause_menu():
	if paused:
		player_menu.hide()
		get_tree
		player.set_physics_process(true) #resumes player movement
	else:
		player_menu.show()
		player.set_physics_process(false) #pauses player movement
	paused = !paused
	
#handles button events
func handle_connect_signal() -> void:
	equipment_btn.button_down.connect(on_equipment_button_press)

#function when equipment button is pressed
func on_equipment_button_press() -> void:
	inventory_container.visible = !inventory_container



