extends Control

signal hover(text)
signal hover_exit(text)
func _on_button_mouse_entered():
	emit_signal("hover", $Button.text)


func _on_button_mouse_exited():
	emit_signal("hover_exit",$Button.text)
