extends EnemyClass

signal boss_trigger
# Called when the node enters the scene tree for the first time.
func _ready():
	# set minion(s) on load
	minion.append("res://Enemies/VampBook/vamp_book.tscn")
	minion.append("res://Enemies/VampBook/vamp_book.tscn")
	# reference to its own scene for battle initialization
	this_scene = "res://Enemies/CountBook/count_book.tscn"
	
	# Show map animation by default
	show_on_map()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Initialize combat on encounter with unit
func _on_body_entered(body):
	emit_signal("boss_trigger")
	if "Player" in body.name && self.visible == true:
		# Play reveal animation. Also runs the initialize combat function and frees queue at the end of the animation
		$AnimationPlayer.play("transform")

