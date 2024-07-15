extends CanvasLayer

var enemy1
var enemy2
var enemy3


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerOptionsContainer/HBoxContainer/Attack.grab_focus()
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
# Populate battle with Enemy and appropriate number of minions
func add_enemies( mainEnemy, minion, numberOfMinions ):
	
	# create instance of main enemy as enemy1 and initalize stats
	enemy1 = load(mainEnemy).instantiate()
	enemy1.initialize_stats_in_combat()
	
	# place main enemy into container
	$EnemiesVContainer/EnemiesHContainer/MiddleEnemy/MiddleEnemyControl.add_child(enemy1)
	enemy1.hide()
	# play spawn animation if exists
	#enemy1.hide()
	#await get_tree().create_timer(1.5).timeout
	enemy1.show()

	# Add requested number of minions
	match numberOfMinions:
		2:
			# Add a minion to the left
			enemy2 = load(minion).instantiate()
			enemy2.initialize_stats_in_combat()
			$EnemiesVContainer/EnemiesHContainer/LeftEnemy/LeftEnemyController.add_child(enemy2)
			enemy2.hide()
			# Add a minion to the right
			enemy3 = load(minion).instantiate()
			enemy3.initialize_stats_in_combat()
			$EnemiesVContainer/EnemiesHContainer/RightEnemy/RightEnemyControl.add_child(enemy3)
			enemy3.hide()
			
		1:
			# Add a minion to the left
			enemy2 = load(minion).instantiate()
			enemy2.initialize_stats_in_combat()
			$EnemiesVContainer/EnemiesHContainer/LeftEnemy/LeftEnemyController.add_child(enemy2)
			enemy2.hide()


#test
func _on_attack_pressed():
	pass
