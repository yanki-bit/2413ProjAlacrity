extends Node
signal contact
@export var next_scene: String = ""
@export var spawn_location = Vector2(0,0)
@export var spawn_direction = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# transition to next scene when player collides with door
func _on_body_entered(body):
	# Make sure body is player
	if "Player" in body.name:
		emit_signal("contact")
		get_node(NodePath("/root/SceneManager")).transition_to_next_scene(next_scene, spawn_location, spawn_direction)

func _on_contact():
	pass
