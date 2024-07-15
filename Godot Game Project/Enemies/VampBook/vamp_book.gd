extends EnemyClass
# reference to its own scene for battle initialization

# Called when the node enters the scene tree for the first time.
func _ready():
	#hid unit on load
	# reference to its own scene for battle initialization
	this_scene = "res://Enemies/VampBook/vamp_book.tscn"
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

		#currently adds 0 minions for test
		fight.add_enemies(this_scene,this_scene,0)
		
		#queue_free()





