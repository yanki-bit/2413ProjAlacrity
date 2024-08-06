extends Node
signal contact
@export var next_scene: String = ""
@export var location: String = ""
@export var direction: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# transition to next scene when player collides with door
func _on_body_entered(body):
	var next_scene_path = MapData.MAPS[next_scene]["scene_path"]
	var spawn_location = MapData.MAPS[next_scene][location]
	var spawn_direction = MapData.MAPS[next_scene][direction]
	
	# Make sure body is player
	if "Player" in body.name:
		emit_signal("contact")
		if PlayerInfo.state["Classroom"] == true && next_scene == "Hallway":
			PlayerInfo.time = 1
			if PlayerInfo.state["Library"] == true && next_scene == "Hallway":
				PlayerInfo.time = 2
			get_node(NodePath("/root/SceneManager")).transition_to_transition_scene()
		else:
			get_node(NodePath("/root/SceneManager")).transition_to_next_scene(next_scene_path, spawn_location, spawn_direction)
		get_node(NodePath("/root/SceneManager")).transition_to_next_scene(next_scene_path, spawn_location, spawn_direction)
