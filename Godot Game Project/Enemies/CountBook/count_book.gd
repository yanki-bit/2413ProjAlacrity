extends EnemyClass

var battle = preload("res://Game/battle_scene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	#hid unit on load
	hide()
	await get_tree().create_timer(5.0).timeout
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
		var fight = battle.instantiate()
		#for n in numberOfMinions:
			#battle.addEnemy()
		#get_parent().add_child(fight)
		#queue_free()
