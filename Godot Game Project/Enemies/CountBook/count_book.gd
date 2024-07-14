extends EnemyClass

# Signals
signal dead

# reference to battle scene
var battle_scene = preload("res://Game/battle_scene.tscn")
# reference to its own scene for battle initialization

var this_scene = "res://Enemies/CountBook/count_book.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	#hid unit on load
	hide()
	show_on_map()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if "Player" in body.name && self.visible == true:
		var numberOfMinions: int = generate_number_of_minions()
		get_tree().paused = true
	
		# Create instance of Battle Scene and add enemies to it
		var fight = battle_scene.instantiate()
		#for n in numberOfMinions:
		get_parent().add_child(fight)
		fight.add_enemies(this_scene,this_scene,0)
		
		#queue_free()


# Stats Setter Functions
func set_MAX_HP(value:int):
	pass

func take_damage(value:int):
#	if stats.CURR_HP
	pass
	



