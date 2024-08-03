extends ProgressBar

var player

# setup HP bar with player node and connect to signals
func set_player(_player):
	player = _player
	player.update_hp_bar.connect(update)
	update()

# function to update the current value of the HP bar
func update():
	value = player.get_CURR_HP() * 100 / player.get_MAX_HP() 
