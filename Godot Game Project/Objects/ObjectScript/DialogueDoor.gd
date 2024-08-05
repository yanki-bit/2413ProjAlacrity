extends Area2D
signal contact
var scene_path: String = MapData.MAPS.Classroom.scene_path
@export var next_scene: String = ""
@export var location: String = ""
@export var direction: String = ""



@export var next_scene2: String = ""
@export var location2 = ""
@export var direction2 = ""

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "MapSelect"
# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueFunctions.connect("sceneOne", Callable(self, "on_scene_one_chosen"))
	DialogueFunctions.connect("sceneTwo", Callable(self, "on_scene_two_chosen"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# transition to next scene when player collides with door
func _on_body_entered(body):
	# Make sure body is player
	if "Player" in body.name:
		emit_signal("contact")
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

func on_scene_one_chosen():
	var scene_path: String = MapData.MAPS[next_scene]["scene_path"]
	var spawn_location = MapData.MAPS[next_scene][location]
	var spawn_direction = MapData.MAPS[next_scene][direction]
	get_node(NodePath("/root/SceneManager")).transition_to_next_scene(scene_path, spawn_location, spawn_direction)
	if PhoneRing.playing:
		PhoneRing.stop()
		Bgm.play()
		
func on_scene_two_chosen():
	var scene_path: String = MapData.MAPS[next_scene2]["scene_path"]
	var spawn_location = MapData.MAPS[next_scene2][location2]
	var spawn_direction = MapData.MAPS[next_scene2][direction2]
	get_node(NodePath("/root/SceneManager")).transition_to_next_scene(scene_path, spawn_location, spawn_direction)
	if PhoneRing.playing:
		PhoneRing.stop()
		Bgm.play()

