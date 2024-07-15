extends EnemyClass

# Called when the node enters the scene tree for the first time.
func _ready():
	# set minion on load
	minion = "res://Enemies/VampBook/vamp_book.tscn"
	
	# reference to its own scene for battle initialization
	this_scene = "res://Enemies/CountBook/count_book.tscn"
	
	# Show map animation by default
	show_on_map()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Initialize combat on encounter with unit
func _on_body_entered(body):
	if "Player" in body.name && self.visible == true:
		# Play reveal animation. Also setup to run the initialize combat function at the end of the animation
		$AnimationPlayer.play("transform")
		
	
