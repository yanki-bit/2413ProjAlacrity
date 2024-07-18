extends EnemyClass
# reference to its own scene for battle initialization

# Called when the node enters the scene tree for the first time.
func _ready():
	# reference to its own scene for battle initialization
	this_scene = "res://Enemies/VampBook/vamp_book.tscn"
	hide()
	show_on_map()
	pass # Replace with function body.


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





