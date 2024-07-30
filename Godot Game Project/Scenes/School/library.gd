extends Room
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String

var state = PlayerInfo.state
# Called when the node enters the scene tree for the first time.
func _ready():
	get_player($Player)
	if state:
		if state.get("Library") == false:
			Dialogue_Handler()

	
func get_player(node : Node):
	node = $Player
	DialogueFunctions.player_node = node

func Dialogue_Handler() -> void:
	DialogueFunctions.dialogue_resource = dialogue_resource
	DialogueFunctions.stop_player_physics()
	DialogueFunctions.playDefaultDialogue(dialogue_start)


func _on_class_door_contact():
	$Player.set_physics_process(false)
