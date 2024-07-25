extends Rooms

# Called when the node enters the scene tree for the first time.
func _ready():
	get_player(player_node)
	Dialogue_Handler()
	DialogueFunctions.connect("dialogue_finished", Callable($Luke, "start_movement"))
	$Luke/Actionable.set_collision_layer_value(5, false)
	$Actionable.connect("interacted", Callable(self, "quiz"))

#function to force the player to face the professor then remove the quiz interactable and make Luke interactable
func quiz():
	$Player.update_animation_parameter(Vector2(0,-1))
	$Actionable.queue_free()
	$Luke/Actionable.set_collision_layer_value(5, true)
	
func get_player(node : Node):
	node = $Player
	DialogueFunctions.player_node = node

func Dialogue_Handler() -> void:
	DialogueFunctions.dialogue_resource = dialogue_resource
	DialogueFunctions.stop_player_physics()
	DialogueFunctions.playDefaultDialogue("School")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
