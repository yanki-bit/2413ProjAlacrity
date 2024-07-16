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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
