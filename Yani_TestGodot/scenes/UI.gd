extends Control

# change keyboard bind through Project > Project Settings > Input Map
# use tab to toggle player menu
func _input(event):
	if event.is_action_pressed("inventory"):
		visible = !visible #for toggling visibility 
