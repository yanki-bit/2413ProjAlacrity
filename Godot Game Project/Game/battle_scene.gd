extends CanvasLayer

var enemy1
var enemy2
var enemy3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func add_enemies( mainEnemy, minion, numberOfMinions):
	
	# create instance of main enemy as enemy1 and initalize stats
	enemy1 = load(mainEnemy).instantiate()
	enemy1.initialize_stats_in_combat()
	
	print(enemy1.ATK)
	
	# place enemy into container
	$EnemiesVContainer/EnemiesHContainer/MiddleEnemy/MiddleEnemyControl.add_child(enemy1)
	
	# play spawn animation if exists
	enemy1.hide()
	await get_tree().create_timer(1.5).timeout
	enemy1.show()
	
	
	match numberOfMinions:
		2:
			$EnemiesVContainer/EnemiesHContainer/RightEnemy/RightEnemyControl.add_child(minion.instantiate())
			$EnemiesVContainer/EnemiesHContainer/LeftEnemy/LeftEnemyController.add_child(minion.instantiate())
		1:
			$EnemiesVContainer/EnemiesHContainer/LeftEnemy/LeftEnemyController.add_child(minion.instantiate())

