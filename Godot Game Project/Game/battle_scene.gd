extends CanvasLayer

var enemies = [] # variables to store enemies in combat.
var player # store player unit
var round_count = 0 # store how many rounds of combat have happened
var turn_count = 0 # store number of turns occured so far in fight 
var current_state    # The current state of the battle
var combat_turn_order = Array()    # A queue of combatants
var units_in_combat = 0 # store number of units still in combat
@onready var ability = $BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/HBoxContainer/PlayerActionCluster/HBoxContainer/Ability

# All possible battle states
enum BATTLE_STATES {
	WAIT,   # Wait for player input
	PLAYER, # When it's time for the player's turn
	ENEMY,  # When it's time for the enemy's turn
	WIN,    # When the player winsx
	LOSE    # When the player loses
}

func update_combat_numbers():
	units_in_combat = combat_turn_order.size()-1
# Called when the node enters the scene tree for the first time.
func _ready():
	handle_signal()
	# Load an instance of player into situation 
	player = load("res://Characters/player.tscn").instantiate()
	# Focus on attack button
	$BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/HBoxContainer/PlayerActionCluster/Attack.grab_focus()
	# Place player in the combat turn order queue to be sorted
	combat_turn_order.append([player,BATTLE_STATES.PLAYER])

#####################################################
##                 INPUT HANDLING                  ##
#####################################################

func _process(delta):
	# Ensure that battle state is waiting for player input
	if current_state == BATTLE_STATES.WAIT:
		if Input.is_action_pressed("pause"):
			$BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/PlayerAbilitiesContainer.hide()
			
		
	

#####################################################
##                 STATE HANDLING                  ##
#####################################################

func _handle_states(new_state):
	# Change state
	current_state = new_state
	match current_state:
		BATTLE_STATES.WAIT:
			# increment round count
			round_count += 1
			# reset turn count
			turn_count = 0
			# increaese energy levels for all combatants by 1 at start of turn
			for i in range(1,combat_turn_order.size()):
				combat_turn_order[i][0].set_ENERGY(combat_turn_order[i][0].get_ENERGY() + 1)
			# Recalculate turn order
			generate_turn_order()
			
			# show player menus
			$BattleSceneContainer/PlayerBG/PlayerContainer.show()
			print("Waiting... round number " + str(round_count))
			
			# wait for player action 
			
		BATTLE_STATES.PLAYER:
			# increment turn count
			turn_count += 1
			
			print("Player Turn")
			await get_tree().create_timer(1).timeout
			
			# perform player action
			_handle_player_state()
			
			# move to next units turn
			_handle_states(check_next_state())
			
			pass
		BATTLE_STATES.ENEMY:
			turn_count += 1
			print("Enemy Turn")
			await get_tree().create_timer(1.5).timeout
			_handle_enemy_state()
			_handle_states(check_next_state())
			pass
		BATTLE_STATES.WIN:
			# Insert code on player win
			# REVERT BUFFS/DEBUFFS ON PLAYER 
			pass
		BATTLE_STATES.LOSE:
			# REVERT BUFFS/DEBUFFS ON PLAYER
			pass

func _handle_enemy_state():
	# use the ability
	
	# Check for stat buff/debuff expiration
	
	# move to next units action
	update_combat_numbers()
	combat_turn_order.append(combat_turn_order.front())
	combat_turn_order.pop_front()
	pass

func _handle_player_state():
	# use the ablility
	use_ability(combat_turn_order[turn_count][0],enemies[0])
	
	# Check for stat buff/debuff expiration
	# move to next units action
	update_combat_numbers()
	combat_turn_order.append(combat_turn_order.front())
	combat_turn_order.pop_front()

func _handle_wait_state():
	# Check if player has selected a priority move:
	
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
	
	# Add wait state to the start of the turn order queue
	# MUST HAPPEN AFTER COMBAT TURN ORDER HAS BEEN SORTED
	# MUST HAPPEN AFTER COMBAT TURN ORDER HAS BEEN SORTED
	# MUST HAPPEN AFTER COMBAT TURN ORDER HAS BEEN SORTED
	combat_turn_order.push_front([null,BATTLE_STATES.WAIT])
	
	#test test test test test
	_handle_states(check_next_state())
	

func sort_decending(a,b):
	if a[0] == null || b[0] == null:
		return false
	elif a[0].get_SPD() > b[0].get_SPD():
		return true
	return false

func generate_turn_order():
	combat_turn_order.sort_custom(sort_decending)

# checks which state to put battle into next based on combat order 
func check_next_state() -> BATTLE_STATES:
	return combat_turn_order[0][1]

@onready var player_abilities_container = $BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/PlayerAbilitiesContainer
@onready var escape = $BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/HBoxContainer/PlayerActionCluster/Escape

func handle_signal():
	ability.pressed.connect(on_ability_press)
	escape.pressed.connect(_on_escape_pressed)
#func to show abilities when button pressed
func on_ability_press() -> void:
	player_abilities_container.show()
	
#####################################################
##                COMBAT HANDLING                  ##
#####################################################
func use_ability(attacker, defender):
	match attacker.next_action:
		# if attacker is using an attack
		Abilities.ABILITY_TYPE.ATTACK:
			attacker.next_action.use.call(attacker, defender)
		Abilities.ABILITY_TYPE.OTHER:
			pass

# # # # # # # # # # # # # # # # #
# TEST TEST TEST TEST TEST TEST #
# # # # # # # # # # # # # # # # #
func _on_attack_pressed():
	# Ensure that player input is expected
	if current_state == BATTLE_STATES.WAIT:
		$BattleSceneContainer/PlayerBG/PlayerContainer.hide()
		# Start turn actions
		_handle_wait_state()
		_handle_states(check_next_state())
	pass

func _on_escape_pressed():
	# Ensure that player input is expected
	if current_state == BATTLE_STATES.WAIT:
		# Unpause Game
		get_tree().paused = false
		get_parent().unpause_player_movement()
		# Delete Battle Scene
		queue_free()

