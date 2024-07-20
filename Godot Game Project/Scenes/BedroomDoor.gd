extends Area2D
signal contact
@export var next_scene: String = ""
@export var spawn_location = Vector2(0,0)
@export var spawn_direction = Vector2(0,0)

@export var next_scene2: String = ""
@export var spawn_location2 = Vector2(0,0)
@export var spawn_direction2 = Vector2(0,0)

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "MapSelect"
# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueFunctions.connect("sceneClass", Callable(self, "on_class_chosen"))
	DialogueFunctions.connect("sceneWork", Callable(self, "on_work_chosen"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# transition to next scene when player collides with door
func _on_body_entered(body):
	# Make sure body is player
	if "Player" in body.name:
		emit_signal("contact")
		print("entered")
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

func on_class_chosen():
	get_node(NodePath("/root/SceneManager")).transition_to_next_scene(next_scene, spawn_location, spawn_direction)
func on_work_chosen():
	get_node(NodePath("/root/SceneManager")).transition_to_next_scene(next_scene2, spawn_location2, spawn_direction2)

	
