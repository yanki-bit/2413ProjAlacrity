extends ProgressBar

#reference to the player character
@export var player: testPlayer

#updates the progress / health bar value
func update():
	value = player.currentHealth * 100 / player.maxHealth

# Called when the node enters the scene tree for the first time.
#func _ready():
#	player.healthChanged.connect(update)
#	update()

