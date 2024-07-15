extends CanvasLayer
# variables to store enemies in combat. Enum to identify enemytype 
var enemy1
var enemy2
var enemy3

enum EnemyType { Minion, Mini_Boss, Boss }

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
	enemy1.show_in_fight()
		# Add requested number of minions
	match numberOfMinions:
		2:
			# Add a minion to the left
			enemy2 = load(minion[0]).instantiate()
			enemy2.initialize_stats_in_combat()
			$EnemiesVContainer/EnemiesHContainer/LeftEnemy/LeftEnemyController.add_child(enemy2)
			enemy2.show_in_fight()
			
			# Add a minion to the right
			enemy3 = load(minion[1]).instantiate()
			enemy3.initialize_stats_in_combat()
			$EnemiesVContainer/EnemiesHContainer/RightEnemy/RightEnemyControl.add_child(enemy3)
			enemy3.show_in_fight()
			
		1:
			# Add a minion to the left
			enemy2 = load(minion[0]).instantiate()
			enemy2.initialize_stats_in_combat()
			$EnemiesVContainer/EnemiesHContainer/LeftEnemy/LeftEnemyController.add_child(enemy2)
			enemy2.show_in_fight()
			


#test
func _on_attack_pressed():
	pass
