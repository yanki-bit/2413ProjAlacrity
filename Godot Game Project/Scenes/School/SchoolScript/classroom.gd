extends Room
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String
var state = PlayerInfo.state
# Called when the node enters the scene tree for the first time.
func _ready():
	get_player($Player)
	if state:
		if state.get("Classroom") == false:
			Dialogue_Handler()
			DialogueFunctions.connect("dialogue_finished", Callable($Luke, "start_movement"))
			$Luke/Actionable.set_collision_layer_value(5, false)
			$Actionable.connect("interacted", Callable(self, "quiz"))
			$Door.monitoring = false
		else:
			$Luke.position = Vector2(68,-49)
			$Luke.update_animation_parameter(Vector2(0,-1))
			$Actionable.queue_free()
			$Door.monitoring = true
			$classDoor.monitoring = false

#function to force the player to face the professor then remove the quiz interactable and make Luke interactable
func quiz():
	$Player.update_animation_parameter(Vector2(0,-1))
	$Actionable.queue_free()
	$Luke/Actionable.set_collision_layer_value(5, true)
	$Door.monitoring = true
	$classDoor.monitoring = false
	
func get_player(node : Node):
	node = $Player
	DialogueFunctions.player_node = node

func Dialogue_Handler() -> void:
	DialogueFunctions.dialogue_resource = dialogue_resource
	DialogueFunctions.stop_player_physics()
	DialogueFunctions.playDefaultDialogue(dialogue_start)
	state["Classroom"] = true
	


func _on_class_door_contact():
	$Player.set_physics_process(false)
