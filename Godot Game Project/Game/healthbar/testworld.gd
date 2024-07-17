extends Node2D

signal textbox_closed

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/BattleDialogue.hide() #hides textbox 
	display_text("a wild enemy has appeared!")
	

func _input(event):
	if ( Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) ) and $CanvasLayer/BattleDialogue.visible():
		$CanvasLayer/BattleDialogue.hide() #hides textbox 
		emit_signal("textbox_closed")
	
func display_text(text):
	$CanvasLayer/BattleDialogue.show() #unhides textbox 
	$CanvasLayer/BattleDialogue/Label.text = text

func _on_run_pressed():
	display_text("You got away safely")
	#yield
	
