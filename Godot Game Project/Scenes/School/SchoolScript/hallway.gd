extends Room
@onready var player_menu = $Player/Camera2D3/Player_Menu

var state = PlayerInfo.state

	
func _on_contact():
	$Player.set_physics_process(false)
# Called when the node enters the scene tree for the first time.
func _ready():
	player_menu.scale = Vector2(0.65,0.65)
	get_player($Player)
	if state:
		if state.get("Classroom") == true && state.get("Bedroom") == true:
			state["Hallway"] = true
			
		if state.get("Hallway") == true:
			$DoorCheck.monitoring = false
			$DoorNorth.monitoring = true
		else:
			$DoorCheck.monitoring = true
			$DoorNorth.monitoring = false
			
func get_player(node : Node):
	DialogueFunctions.player_node = node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_door_check_contact():
	$Player.set_physics_process(false)
