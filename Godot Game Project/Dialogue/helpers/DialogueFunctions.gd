extends Node


var player_node: Node = null
var day = 0

	
func set_player_node(node: Node):
	player_node = node

func stop_player_physics():
	if player_node:
		player_node.set_physics_process(false)
		
func start_player_physics():
	if player_node:
		player_node.set_physics_process(true)
		
func add_game_day(AddDay = 1) -> void:
	day += AddDay
	
