extends Room
@onready var bedroom = $"."
@onready var player_menu = $Player/Camera2D3/Player_Menu

@export var dialogue_resource: DialogueResource
var player_node : Node = null
var state = PlayerInfo.state
# Called when the node enters the scene tree for the first time.
func _ready():
	player_menu.scale = Vector2(0.4,0.4)
	get_player(player_node)
	if state:
		if state.get("Bedroom") == false: # If true, does not play intro dialogue
			PhoneRing.play()
		
	Dialogue_Handler()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
#function to get the player node to stop its process using dialogue
func get_player(node : Node):
	node = $Player
	DialogueFunctions.player_node = node

#function to start player movement
	
#function to handle dialogue sequence
func Dialogue_Handler() -> void:
	if state.get("Bedroom") == false:
		DialogueFunctions.dialogue_resource = dialogue_resource
		DialogueFunctions.stop_player_physics()
		DialogueFunctions.playDialogue("DayOne")
		DialogueFunctions.playDefaultDialogue("Monologue1")
		state["Bedroom"] = true

# Pause Player movement on contact to set animation to idle
func _on_contact():
	$Player.set_physics_process(false)


func _on_actionable_interacted():
	PhoneRing.stop()
	if Bgm.playing == false:
		Bgm.play()
