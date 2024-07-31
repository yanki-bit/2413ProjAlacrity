extends EnemyClass
# reference to its own scene for battle initialization

# Called when the node enters the scene tree for the first time.
func _ready():
	# reference to its own scene for battle initialization
	this_scene = "res://Enemies/VampBook/vamp_book.tscn"
	hide()
	show_on_map()
	pass # Replace with function body.

#####################################################
##                 SELECT ACTION                   ##
#####################################################

func choose_action():
	# check current energy 
	match get_ENERGY():
		# if 0 energy (should not be possible), use defend
		0:
			next_action = learned_abilities[1]
		# if 1 energy, choose between attack and defend 50/50
		1: 
			var option_selected = randi_range(0,1)
			# if 0 use attack,1 use defend
			next_action = learned_abilities[option_selected]
		# if 2 or more energy, use bite
		_: 
			next_action = learned_abilities[2]
	
	next_action = Abilities.ABILITIES.get(next_action)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(body):
	if "Player" in body.name && self.visible == true:
		emit_signal("contact")
		# slight pause to allow player idle animation to begin
		await get_tree().create_timer(.1).timeout
		initalize_combat()
		queue_free()





