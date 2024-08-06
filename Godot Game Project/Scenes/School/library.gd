extends Room
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String
@onready var player_menu = $Player/Camera2D3/Player_Menu
var state = PlayerInfo.state
# Called when the node enters the scene tree for the first time.
func _ready():
	player_menu.scale = Vector2(0.4,0.4)
	get_player($Player)
	if state:
		if state.get("Library") == false:
			Dialogue_Handler()
	var node_to_watch = $CountBook
	node_to_watch.connect("tree_exited",Callable(self,"_on_boss_defeat"))
	
func get_player(node : Node):
	node = $Player
	DialogueFunctions.player_node = node

func Dialogue_Handler() -> void:
	DialogueFunctions.dialogue_resource = dialogue_resource
	DialogueFunctions.stop_player_physics()
	DialogueFunctions.playDefaultDialogue(dialogue_start)

#this is a very poor way of handling this event
func _on_boss_defeat():
	$Player.process_mode = 4
	dialogue_start = "BossDefeat"
	var delay = Timer.new()
	delay.wait_time = 0.5
	delay.one_shot = true
	add_child(delay)
	delay.start()
	await delay.timeout
	DialogueFunctions.playDefaultDialogue(dialogue_start)
	delay.start()
	await delay.timeout
	$Player.process_mode = 0
	
func _on_class_door_contact():
	$Player.set_physics_process(false)
