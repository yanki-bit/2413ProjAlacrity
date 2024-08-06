extends Control

signal hover(text)
signal hover_exit(text)
signal click(text)

@onready var label = $RichTextLabel
@onready var button = $Button

func _on_button_mouse_entered():
	emit_signal("hover", $Button.text)


func _on_button_mouse_exited():
	emit_signal("hover_exit",$Button.text)



func _on_button_pressed():
	emit_signal("click", $Button.text)
