extends CanvasLayer

var enemies = [] # variables to store enemies in combat. Enum to identify enemytype 
var player # store player unit
var turn_count = 0 # store number of turns occured so far in fight 
var current_state    # The current state of the battle
var combat_turn_order = Array()    # A queue of combatants

# All possible battle states
enum BATTLE_STATES {
	WAIT,   # Wait for player input
	PLAYER, # When it's time for the player's turn
	ENEMY,  # When it's time for the enemy's turn
	WIN,    # When the player wins
	LOSE    # When the player loses
}

# Called when the node enters the scene tree for the first time.
func _ready():
	# Load an instance of player into situation 
	player = load("res://Characters/player.tscn").instantiate()
	# Focus on attack button
	$BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/HBoxContainer/PlayerActionCluster/Attack.grab_focus()
	# Place player in the combat turn order queue to be sorted
	combat_turn_order.append([player,BATTLE_STATES.PLAYER])

#####################################################
##                 STATE HANDLING                  ##
#####################################################

func _handle_states(new_state):
	# Change state
	current_state = new_state
	match current_state:
		BATTLE_STATES.WAIT:
			# Increment Turn
			turn_count += 1
			# show player menus
			$BattleSceneContainer/PlayerBG/PlayerContainer.show()
			print("Waiting... turn number" + str(turn_count))
			# wait for player action 
			
		BATTLE_STATES.PLAYER:
			print("Player Turn")
			await get_tree().create_timer(1).timeout
			_handle_player_state()
			_handle_states(check_next_state())
			pass
		BATTLE_STATES.ENEMY:
			print("Enemy Turn")
			await get_tree().create_timer(1.5).timeout
			_handle_enemy_state()
			_handle_states(check_next_state())
			pass
		BATTLE_STATES.WIN:
			# Insert code on player win
			pass
		BATTLE_STATES.LOSE:
			# Insert code on player lose
			pass

func _handle_enemy_state():
	# get enemy to take action
	# move to next units action
	combat_turn_order.append(combat_turn_order.front())
	combat_turn_order.pop_front()
	pass

func _handle_player_state():
	# do players action
	# move to next units action
	combat_turn_order.append(combat_turn_order.front())
	combat_turn_order.pop_front()

func _handle_wait_state():
	# Moves queue to start turn when player action is selected
	combat_turn_order.append(combat_turn_order.front())
	combat_turn_order.pop_front()




# Populate battle with Enemy and appropriate number of minions
func add_enemies( mainEnemy, minion, numberOfMinions ):
	# create instance of main enemy as enemies[0] and initalize stats
	enemies.insert(0,load(mainEnemy).instantiate())
	enemies[0].initialize_stats_in_combat()

	# place main enemy into container
	$BattleSceneContainer/EnemiesContainer/MiddleEnemy/MiddleEnemyControl.add_child(enemies[0])
	enemies[0].show_in_fight()
	
	# Add main enemy to combat turn order array
	combat_turn_order.append([enemies[0],BATTLE_STATES.ENEMY])
		
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
			# Add minions to combat turn order array
			combat_turn_order.append([enemies[1],BATTLE_STATES.ENEMY])
			combat_turn_order.append([enemies[2],BATTLE_STATES.ENEMY])
		1:
			# Add a minion to the left
			enemies.insert(1,load(minion[0]).instantiate())
			enemies[1].initialize_stats_in_combat()
			$BattleSceneContainer/EnemiesContainer/LeftEnemy/LeftEnemyController.add_child(enemies[1])
			enemies[1].show_in_fight()
			combat_turn_order.append([enemies[1],BATTLE_STATES.ENEMY])
	
	# generate the turn order
	generate_turn_order()
	
	# set energy levels for all combatants to 1 at start of turn
	for i in combat_turn_order.size():
		combat_turn_order[i][0].set_ENERGY(1)
	#testestestestesetesttestestestestestestest
	for i in combat_turn_order.size():
		print(combat_turn_order[i][0].get_SPD())
	
	# Add wait state to the start of the turn order queue
	# MUST HAPPEN AFTER COMBAT TURN ORDER HAS BEEN SORTED
	# MUST HAPPEN AFTER COMBAT TURN ORDER HAS BEEN SORTED
	# MUST HAPPEN AFTER COMBAT TURN ORDER HAS BEEN SORTED
	combat_turn_order.push_front([null,BATTLE_STATES.WAIT])
	
	#test test test test test
	_handle_states(check_next_state())
	

func sort_decending(a,b):
	if a[0].get_SPD() > b[0].get_SPD():
		return true
	return false

func generate_turn_order():
	combat_turn_order.sort_custom(sort_decending)

# checks which state to put battle into next based on combat order 
func check_next_state() -> BATTLE_STATES:
	return combat_turn_order[0][1]




# # # # # # # # # # # # # # # # #
# TEST TEST TEST TEST TEST TEST #
# # # # # # # # # # # # # # # # #
func _on_attack_pressed():
	if current_state == BATTLE_STATES.WAIT:
		$BattleSceneContainer/PlayerBG/PlayerContainer.hide()
		# Start turn actions
		_handle_wait_state()
		_handle_states(check_next_state())
	pass
