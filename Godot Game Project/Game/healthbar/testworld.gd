extends Node2D

signal textbox_closed

var currentHealth = 35
var max_health = 35	
var playerDamage = 20

var enemyHealth = 40
var enemyMax_health = 40	
var enemyDamage = 15

#for the turn based combat
var current_player_health = 0
var current_enemy_health = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#set the health bar
	set_health($Panel/PlayerData/healthBarv3, currentHealth, max_health)
	set_enemyHealth($Enemy2/enemyHealth, enemyHealth, enemyMax_health)
	
	#track over the course of battle
	current_player_health = currentHealth
	current_enemy_health = enemyHealth
	
	$CanvasLayer/BattleDialogue.hide() #hides textbox
	display_text("a wild enemy has appeared!")
	await textbox_closed


func set_health(progress_bar, health, max_health):
	#sets the player health bar
	$Panel/PlayerData/healthBarv3.value = health
	$Panel/PlayerData/healthBarv3.max_value = health
	$Panel/PlayerData/healthBarv3.get_node("Label").text = "HP:%d / %d" % [health, max_health]
	
func set_enemyHealth(progress_bar, enemyHealth, enemyMax_health):
	#sets enemy health
	$Enemy2/enemyHealth.value = enemyHealth
	$Enemy2/enemyHealth.max_value = enemyHealth
	$Enemy2/enemyHealth.get_node("Label").text = "HP:%d / %d" % [enemyHealth, enemyMax_health]
	
#this lets the user progress dialogue and tells the game when to hide the dialogue box
func _input(event):
	if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and $CanvasLayer/BattleDialogue.visible:
		$CanvasLayer/BattleDialogue.hide() #hides textbox 
		emit_signal("textbox_closed")
	
func display_text(text):
	$CanvasLayer/BattleDialogue.show() #unhides textbox 
	$CanvasLayer/BattleDialogue/Label.text = text

func _on_run_pressed():
	display_text("You got away safely")
	await textbox_closed
	await get_tree().create_timer(0.5).timeout
	get_tree().quit() #quits the game 
	

func _on_attack_pressed():
	display_text("You swing your weapon at the enemy!")
	current_enemy_health = max(0, current_enemy_health - playerDamage)
	#update enemy health
	set_enemyHealth($Enemy2/enemyHealth, current_enemy_health, enemyMax_health)
	
