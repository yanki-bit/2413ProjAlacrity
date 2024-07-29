# programmer: Yani
# script usage: attach to enemy or player node and reference healthbar inside those scripts

extends ProgressBar

# this is for the timer
@onready var timer = $Timer
@onready var damage_bar = $DamageBar

# the variable below is initialized by the scene it is attached to
var health = 0 : set = _set_health

func _set_health(new_health):
	var prev_health = health #sets old health to current health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free() #called because it won't be needed anymore for this scenario
	
	#taking damage
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health
		

func _init_health(_health):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health
	

#this allows the damage bar to catch up with the health bar
func _on_timer_timeout():
	damage_bar.value = health




