extends CanvasLayer
# variables to store enemies in combat. Enum to identify enemytype 
var enemies = []
var player
# All possible battle states
enum BATTLE_STATES {
 PLAYER,    # When it's time for the player's turn
 ENEMY,    # When it's time for the enemy's turn
 WIN,    # When the player wins
 LOSE    # When the player loses
}

var current_state    # The current state of the battle

var combat_turn_order = Array()    # A queue of combatants

# Called when the node enters the scene tree for the first time.
func _ready():
	player = load("res://Characters/player.tscn").instantiate()
	# Focus on attack button
	$BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/HBoxContainer/PlayerActionCluster/Attack.grab_focus()
	_handle_states(BATTLE_STATES.PLAYER)
	print(player.statsheet.SPD)
	pass
	
func _handle_states(new_state):
	# Change state
	current_state = new_state
	match current_state:
		BATTLE_STATES.PLAYER:
			show()
			pass
		BATTLE_STATES.ENEMY:
			print("worldstar")
			
			pass
		BATTLE_STATES.WIN:
			# Insert code on player win
			pass
		BATTLE_STATES.LOSE:
			# Insert code on player lose
			pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
# Populate battle with Enemy and appropriate number of minions
func add_enemies( mainEnemy, minion, numberOfMinions ):
	# create instance of main enemy as enemies[0] and initalize stats
	enemies.insert(0,load(mainEnemy).instantiate())
	enemies[0].initialize_stats_in_combat()

	# place main enemy into container
	$BattleSceneContainer/EnemiesContainer/MiddleEnemy/MiddleEnemyControl.add_child(enemies[0])
	enemies[0].show_in_fight()
		# Add requested number of minions
	match numberOfMinions:
		2:
			# Add a minion to the left
			enemies.insert(1,load(minion[0]).instantiate())
			enemies[1].initialize_stats_in_combat()
			$BattleSceneContainer/EnemiesContainer/LeftEnemy/LeftEnemyController.add_child(enemies[1])
			enemies[1].show_in_fight()
			
			# Add a minion to the right
			enemies.insert(2,load(minion[1]).instantiate())
			enemies[2].initialize_stats_in_combat()
			$BattleSceneContainer/EnemiesContainer/RightEnemy/RightEnemyControl.add_child(enemies[2])
			enemies[2].show_in_fight()
			
		1:
			# Add a minion to the left
			enemies.insert(1,load(minion[0]).instantiate())
			enemies[1].initialize_stats_in_combat()
			$BattleSceneContainer/EnemiesContainer/LeftEnemy/LeftEnemyController.add_child(enemies[1])
			enemies[1].show_in_fight()
	
	# populate turn order array
	combat_turn_order.append(player)
	combat_turn_order.append(enemies[0])

	generate_turn_order()
	
	
func sort_decending(a,b):
	if a.SPD > b.SPD:
		return true
	return false

func generate_turn_order():
	combat_turn_order.sort_custom(sort_decending)


#test
func _on_attack_pressed():
	print(player.statsheet.ATK)
	if current_state == BATTLE_STATES.PLAYER:
		print("hello")
		_handle_states(BATTLE_STATES.ENEMY)
	pass
