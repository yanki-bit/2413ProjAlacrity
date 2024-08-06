extends EnemyClass
# Called when the node enters the scene tree for the first time.
func _ready():
	# set minion(s) on load
	minion.append("res://Enemies/VampBook/vamp_book.tscn")
	minion.append("res://Enemies/VampBook/vamp_book.tscn")
	# reference to its own scene for battle initialization
	this_scene = "res://Enemies/CountBook/count_book.tscn"
	
	Name = "Count BookShelf"
	# Show map animation by default
	show_on_map()

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
		# if 2 energy, choose between bite, defend and attack
		2:
			var option_selected = randi_range(0,2)
			next_action = learned_abilities[option_selected]
		# if 3+ energy, use drain
		_:
			next_action = learned_abilities[3]

	next_action = Abilities.ABILITIES.get(next_action)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Initialize combat on encounter with unit
func _on_body_entered(body):
	if "Player" in body.name && self.visible == true:
		BattleMusic.stream = preload("res://Assets/Music/Accept-The-Challenge-chosic.com_.mp3")
		PlayerInfo.state["Library"] = true
		$"../LibraryDoor".monitoring = false
		emit_signal("contact")
		# Play reveal animation. Also runs the initialize combat function and frees queue at the end of the animation
		$AnimationPlayer.play("transform")


