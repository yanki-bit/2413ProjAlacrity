extends CanvasLayer

var enemies = [] # variables to store enemies in combat.
var combat_type # store if battle is a regular fight or a boss fight
enum EnemyType { Minion, Mini_Boss, Boss }
var player # store player unit
var round_count = 0 # store how many rounds of combat have happened
var turn_count = 0 # store number of turns occured so far in fight 
var current_state    # The current state of the battle
var combat_turn_order = Array()    # A queue of combatants
var units_in_combat = 0 # store number of units still in combat
var combat_log = "" # stores combat message to be displayed

signal action_selected

@onready var ability = $BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/HBoxContainer/PlayerActionCluster/HBoxContainer/Ability
@onready var player_abilities_container = $BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/PlayerAbilitiesContainer
@onready var escape = $BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/HBoxContainer/PlayerActionCluster/Escape
@onready var ability_1 = $BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/PlayerAbilitiesContainer/NinePatchRect/MarginContainer/HBoxContainer/VBoxContainer/Ability_1
@onready var ability_2 = $BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/PlayerAbilitiesContainer/NinePatchRect/MarginContainer/HBoxContainer/VBoxContainer/Ability_2
@onready var ability_3 = $BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/PlayerAbilitiesContainer/NinePatchRect/MarginContainer/HBoxContainer/VBoxContainer2/Ability_3
@onready var ability_4 = $BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/PlayerAbilitiesContainer/NinePatchRect/MarginContainer/HBoxContainer/VBoxContainer2/Ability_4

# All possible battle states
enum BATTLE_STATES {
	WAIT,   # Wait for player input
	PLAYER, # When it's time for the player's turn
	ENEMY,  # When it's time for the enemy's turn
	WIN,    # When the player winsx
	LOSE,   # When the player loses
	MESSAGE # When the game is showing a player a message
}

func update_combat_numbers():
	units_in_combat = combat_turn_order.size() - 1

# Called when the node enters the scene tree for the first time.
func _ready():
	%NameTag.text = PlayerInfo.player_name
	BattleMusic.play()
	# setup button handling
	handle_signal()
	# Load an instance of player into situation 
	player = load("res://Characters/player.tscn").instantiate()
	# Set player energy at for the beginning of each fight 
	player.set_ENERGY(0)
	# Setup player HP bar
	$BattleSceneContainer/PlayerBG/PlayerContainer/PortraitContainer/NinePatchRect/VBoxContainer/MarginContainer/HealthBar.set_unit(player)
	# Setup BattleSceneEffects with player
	$BattleSceneEffects.set_player(player)
	# Setup Player Portrait with player
	$BattleSceneContainer/PlayerBG/PlayerContainer/PortraitContainer/NinePatchRect/VBoxContainer/CenterContainer/Control/PlayerSprite.set_player(player)
	# Populate player ability buttons with players learned abilites
	%Attack.text = player.get_learned_abilities(0)
	populate_ability_buttons()
	# Focus on attack button
	%Attack.grab_focus()
	
	# Place player in the combat turn order queue to be sorted
	combat_turn_order.append([player,BATTLE_STATES.PLAYER])

# Populate player ability buttons with players learned abilites NOT A GREAT SOLUTION!
func populate_ability_buttons():
	var i = 1
	for button in $BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/PlayerAbilitiesContainer/NinePatchRect/MarginContainer/HBoxContainer/VBoxContainer.get_children():
		button.text = player.get_learned_abilities(i)
		i += 1
	for button in $BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/PlayerAbilitiesContainer/NinePatchRect/MarginContainer/HBoxContainer/VBoxContainer2.get_children():
		button.text = player.get_learned_abilities(i)
		i += 1




#####################################################
##          COMBAT NOTIFICAION FUNCTIONS           ##
#####################################################

func show_message(message: String):
	# set message
	%Message.text = message
	# show message panel
	%CombatNotification.show()

func hide_message():
	%CombatNotification.hide()

#####################################################
##                 INPUT HANDLING                  ##
#####################################################

func _process(_delta):
	
	# Ensure that battle state is waiting for player input
	if current_state == BATTLE_STATES.WAIT:
		if Input.is_action_pressed("pause"):
			# hide all submenus to go back to original fight menu
			$BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/PlayerAbilitiesContainer.hide()
	if current_state == BATTLE_STATES.WIN:
		if Input.is_action_pressed("ui_select"):
			# unpause game 
			BattleMusic.stop()
			get_tree().paused = false
			get_parent().unpause_player_movement()
			queue_free()
			

func handle_signal():
	ability.pressed.connect(on_ability_press)
	escape.pressed.connect(on_escape_pressed)
	ability_1.pressed.connect(on_ability_1_pressed)
	ability_2.pressed.connect(on_ability_2_pressed)
	ability_3.pressed.connect(on_ability_3_pressed)
	ability_4.pressed.connect(on_ability_4_pressed)

func process_next_action(action: String):
	# takes in next action and finds associated ability
	var next_action = Abilities.ABILITIES.get(action)
	
	# check to ensure that player has enough energy to use the ability
	if player.get_ENERGY() >= next_action.energy_cost:
		# hide player buttons UI
		$BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/HBoxContainer/PlayerActionCluster.hide()
		$BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/PlayerAbilitiesContainer.hide()
		# start turn if player has enough energy
		player.next_action = next_action
		_handle_wait_state()
		_handle_states(check_next_state())
	else:
		show_message("Not enough Energy!")
		await get_tree().create_timer(2).timeout
		hide_message()


#func to show abilities when button pressed
func on_ability_press() -> void:
	player_abilities_container.show()

func on_ability_1_pressed():
	emit_signal("action_selected", %Ability_1.text)
	
func on_ability_2_pressed():
	emit_signal("action_selected", %Ability_2.text)

func on_ability_3_pressed():
	emit_signal("action_selected", %Ability_3.text)

func on_ability_4_pressed():
	emit_signal("action_selected", %Ability_4.text)
	
func _on_attack_pressed():
	emit_signal("action_selected", %Attack.text)

func on_escape_pressed():
	# Ensure that player input is expected
	if current_state == BATTLE_STATES.WAIT:
		if combat_type != EnemyType.Boss:
			# Unpause Game
			BattleMusic.stop()
			get_tree().paused = false
			get_parent().unpause_player_movement()
			# Delete Battle Scene
			queue_free()
		else:
			show_message("You can't run away from the Boss!")
			await get_tree().create_timer(2).timeout
			hide_message()


#####################################################
##                 STATE HANDLING                  ##
#####################################################

func _handle_states(new_state):
	# Change state
	current_state = new_state
	match current_state:
		BATTLE_STATES.WAIT:
			# get focus on attack button again
			%Attack.grab_focus()
			# increment round count
			round_count += 1
			# reset turn count
			turn_count = 0
			# increaese energy levels for all combatants by 1 at start of turn
			for i in range(1,combat_turn_order.size()):
				combat_turn_order[i][0].set_ENERGY(combat_turn_order[i][0].get_ENERGY() + 1)
			# Recalculate turn order
			generate_turn_order()
			print("player energy = " + str(player.get_ENERGY()))
			print("player defense = " + str(player.get_DEF()))
			print("player HP = " + str(player.get_CURR_HP()))
			
			print("enemy energy = " + str(enemies[0].get_ENERGY()))
			print("enemy defense = " + str(enemies[0].get_DEF()))
			print("enemy HP = " + str(enemies[0].get_CURR_HP()))
			# show player menus
			$BattleSceneContainer/PlayerBG/PlayerContainer/PlayerActionsContainer/HBoxContainer/PlayerActionCluster.show()
			print("Waiting... round number " + str(round_count))
			# print("units in combat turn order: " + str(combat_turn_order.size()))
			# wait for player action 
			
		BATTLE_STATES.PLAYER:
			# increment turn count
			turn_count += 1
			
			print("Player Turn")
			# perform player action
			_handle_player_state()
			
			hide_message()
			
			# check if player has won
			check_player_win()
			
			# move to message state to display combat log to player
			combat_turn_order.insert(1,[null,BATTLE_STATES.MESSAGE])
			move_to_next_unit()
			_handle_states(check_next_state())
			

		BATTLE_STATES.ENEMY:
			# increment turn count
			turn_count += 1
			print("Enemy Turn")

			
			# perform enemy action
			_handle_enemy_state()
			
			# check if enemy has won
			check_enemy_win()
			
			# move to message state to display combat log to player
			combat_turn_order.insert(1,[null,BATTLE_STATES.MESSAGE])
			move_to_next_unit()
			_handle_states(check_next_state())

		BATTLE_STATES.WIN:
			_handle_win_state()
			
		BATTLE_STATES.LOSE:
			_handle_lose_state()
			
		BATTLE_STATES.MESSAGE:
			# show message that is stored in the combat log
			show_message(combat_log)
			await get_tree().create_timer(1.5).timeout
			hide_message()
			
			#check for player win/loss
			if check_player_win():
				combat_turn_order.insert(1,[null,BATTLE_STATES.WIN])
				print("here")
			if check_enemy_win():
				combat_turn_order.insert(1,[null,BATTLE_STATES.LOSE])
			
			# move to next state
			combat_turn_order.pop_front()
			_handle_states(check_next_state())

func _handle_wait_state():
	# Moves queue to start turn when player action is selected
	combat_turn_order.append(combat_turn_order.front())
	combat_turn_order.pop_front()

func _handle_player_state():
	# Create temporary attacker variable
	var attacker = combat_turn_order.front().front()
	
	# Decrement attackers statmods array by 1 round
	attacker.decrement_statmods_duration()
	
	# use the ablility 
	use_ability(attacker,enemies[0]) # SET TO ENEMIES 0 FOR PURPOSE OF DEMO TEST ONLY
	
	# TODO ANIMATION HERE
	
	# remove expired statmods 
	attacker.remove_expired_statmods()
	
	# remove dead combatants
	remove_dead_units()

# check if player has won by eliminating all units in the fight
func check_player_win() -> bool:
	var player_win = true
	for i in combat_turn_order.size():
		if combat_turn_order[i][1] == BATTLE_STATES.ENEMY:
			player_win = false
	return player_win

func _handle_enemy_state():
	# Create temporary attacker variable
	var attacker = combat_turn_order.front().front()
	
	# Decrement attackers statmods array by 1 round
	attacker.decrement_statmods_duration()
	
	# CALL ENEMY AI DECISION FUNCTION 
	attacker.choose_action()
	
	# use the ablility 
	use_ability(attacker, player) 
	
	# TODO ANIMATION HERE

	
	# remove expired statmods 
	attacker.remove_expired_statmods()
	
	# remove dead combatants
	remove_dead_units()

# check if enemy has won by eliminating the player
func check_enemy_win() -> bool:
	var enemy_win = true
	for i in combat_turn_order.size():
		if combat_turn_order[i].back() == BATTLE_STATES.PLAYER:
			enemy_win = false
	# if player is no longer in the combat turn order array, enemy wins
	return enemy_win

func _handle_win_state():
	# Show win message and end combat
	show_message("You Win! \n Press \"Space\" to continue")
	await get_tree().create_timer(2).timeout
	# Remove all combat arrays
	player.empty_statmods_array()
	player.empty_defmods_array()
	player.empty_atkmods_array()

func _handle_lose_state():
	# Show loss message
	show_message("You Passed Out")
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	
	# Send player back to main menu 
	var lose_scene = preload("res://Scenes/Intro/Defeat.tscn") as PackedScene
	get_tree().change_scene_to_packed(lose_scene)
# Move to next unit
func move_to_next_unit():
	# move to next units action
	combat_turn_order.append(combat_turn_order.front())
	combat_turn_order.pop_front()


# Remove Dead units
func remove_dead_units():
	# go through each unit to check if it still has hp left. play death animation, remove from turn order
	# and free queue here
	combat_turn_order = combat_turn_order.filter(remove_dead_units_helper)

# returns true if alive, false if dead
func remove_dead_units_helper(unit):
	
	if unit[1] == BATTLE_STATES.WAIT || unit[1] == BATTLE_STATES.MESSAGE:
		return true
	# if current hp is less than 0
	elif unit[0].get_CURR_HP() <= 0:
		#play units death animation
		
		unit[0].play_death_animation()
		return false
	return true
	

# Populate battle with Enemy and appropriate number of minions
func add_enemies( mainEnemy, minion, numberOfMinions ):
	# create instance of main enemy as enemies[0] and initalize stats
	enemies.insert(0,load(mainEnemy).instantiate())
	enemies[0].initialize_stats_in_combat()
	combat_type = enemies[0].type

	# place main enemy into container
	$BattleSceneContainer/EnemiesContainer/MiddleEnemyContainer/MiddleEnemy/MiddleEnemyControl.add_child(enemies[0])
	enemies[0].show_in_fight()
	
	# connect main enemy with middle enemy container hp bar and show to player
	$BattleSceneContainer/EnemiesContainer/MiddleEnemyContainer/MarginContainer/HealthBar.set_unit(enemies[0])
	$BattleSceneContainer/EnemiesContainer/MiddleEnemyContainer/MarginContainer/HealthBar.show()
	
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
			
			# connect left enemy with left enemy container hp bar and show to player
			$BattleSceneContainer/EnemiesContainer/LeftEnemyContainer/MarginContainer/HealthBar.set_unit(enemies[1])
			$BattleSceneContainer/EnemiesContainer/LeftEnemyContainer/MarginContainer/HealthBar.show()
			
			# Add a minion to the right
			enemies.insert(2,load(minion[1]).instantiate())
			enemies[2].initialize_stats_in_combat()
			$BattleSceneContainer/EnemiesContainer/RightEnemy/RightEnemyControl.add_child(enemies[2])
			enemies[2].show_in_fight()
			# Add minions to combat turn order array
			combat_turn_order.append([enemies[1],BATTLE_STATES.ENEMY])
			combat_turn_order.append([enemies[2],BATTLE_STATES.ENEMY])
			
			# connect right enemy with right enemy container hp bar and show to player
			$BattleSceneContainer/EnemiesContainer/RightEnemyContainer/MarginContainer/HealthBar.set_unit(enemies[2])
			$BattleSceneContainer/EnemiesContainer/RightEnemyContainer/MarginContainer/HealthBar.show()
		1:
			# Add a minion to the left
			enemies.insert(1,load(minion[0]).instantiate())
			enemies[1].initialize_stats_in_combat()
			$BattleSceneContainer/EnemiesContainer/LeftEnemy/LeftEnemyController.add_child(enemies[1])
			enemies[1].show_in_fight()
			combat_turn_order.append([enemies[1],BATTLE_STATES.ENEMY])
			
			# connect left enemy with left enemy container hp bar and show to player
			$BattleSceneContainer/EnemiesContainer/LeftEnemyContainer/MarginContainer/HealthBar.set_unit(enemies[1])
			$BattleSceneContainer/EnemiesContainer/LeftEnemyContainer/MarginContainer/HealthBar.show()
	
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



#####################################################
##                COMBAT HANDLING                  ##
#####################################################

func use_ability(attacker, defender):
	#obtain name of attacker if enemy unit
	var attacker_name : String
	# provide name of enemy if attacker is enemy
	if combat_turn_order.front().back() == BATTLE_STATES.ENEMY:
		attacker_name = attacker.get_Name()
	# use "you" to describe the player 
	else:
		attacker_name = "You"
	
	combat_log = attacker_name + " used " + attacker.next_action.name + "! \n"
	match attacker.next_action.type:
		# if attacker is using an attack
		Abilities.ABILITY_TYPE.ATTACK:
			# execute attack on the target
			var damage_dealt = attacker.next_action.use.call(attacker, defender)
			combat_log += attacker_name + " did " + str(damage_dealt) + " Damage"

		# If attacker is healing, gaining energy or buffing itself
		Abilities.ABILITY_TYPE.HEAL:
			# execute ability on self
			var heal = attacker.next_action.use.call(attacker)
			combat_log += attacker_name + " healed for " + str(heal) + " Health"

		Abilities.ABILITY_TYPE.ENERGY:
			# execute ability on self
			var energy_gained = attacker.next_action.use.call(attacker)
			combat_log += attacker_name + " gained " + str(energy_gained) + " Energy"
		
		Abilities.ABILITY_TYPE.BUFF:
			# execute ability on self
			attacker.next_action.use.call(attacker)
			combat_log += attacker.next_action.description

		# If attacker is debuffing the enemy
		Abilities.ABILITY_TYPE.DEBUFF:
			# execute ability on enemy
			attacker.next_action.use.call(defender)
			combat_log += attacker.next_action.description
	show_message(combat_log)
