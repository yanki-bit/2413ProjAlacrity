extends Room
@onready var player_menu = $Player/Camera2D3/Player_Menu
func _on_contact():
	$Player.set_physics_process(false)
# Called when the node enters the scene tree for the first time.
func _ready():
	player_menu.scale = Vector2(0.65,0.65)
	get_player($Player)

func get_player(node : Node):
	DialogueFunctions.player_node = node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
