extends ProgressBar

var unit
var stylebox
var new_value
# setup HP bar with unit node and connect to signals
func set_unit(_unit):
	unit = _unit
	unit.update_hp_bar.connect(update)
	value = unit.get_CURR_HP() * 100 / unit.get_MAX_HP()
	stylebox = self.get("theme_override_styles/fill")
	update()

# function to update the current value of the HP bar
func update():
	# set new value
	new_value = unit.get_CURR_HP() * 100 / unit.get_MAX_HP() 

	# Create tween to move healbar to new value over 1 second
	var tween = create_tween()
	tween.tween_property(self, "value",new_value,1)
	tween.connect("finished", change_color)

func change_color():
	value = new_value
	# check value to determine color of health bar based on how much hp is left
	if value >= 60:
		stylebox.bg_color = Color.DARK_GREEN
	elif (value >= 20 && value < 60):
		stylebox.bg_color = Color.CORAL
	else:
		stylebox.bg_color = Color.RED

