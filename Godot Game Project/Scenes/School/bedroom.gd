extends Room
@onready var bedroom = $"."
@onready var player_menu = $Player/Camera2D3/Player_Menu

@onready var phone_ring = $PhoneRing as AudioStreamPlayer2D

@export var dialogue_resource: DialogueResource
var player_node : Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	player_menu.scale = Vector2(0.65,0.65)
	get_player(player_node)
	Dialogue_Handler()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
#function to get the player node to stop its process using dialogue
func get_player(node : Node):
	node = $Player
	DialogueFunctions.player_node = node

#controls music player
func play_music(music: AudioStreamPlayer2D):
	music.play()
	pass
func stop_music (music: AudioStreamPlayer2D):
	music.stop()
	pass

#function to start player movement
	
#function to handle dialogue sequence
func Dialogue_Handler() -> void:
	DialogueFunctions.dialogue_resource = dialogue_resource
	DialogueFunctions.stop_player_physics()
	DialogueFunctions.playDialogue("DayOne")
	DialogueFunctions.playDefaultDialogue("Monologue1")

# Pause Player movement on contact to set animation to idle
func _on_contact():
	$Player.set_physics_process(false)


func _on_actionable_interacted():
	stop_music(phone_ring)	
	if Bgm.playing == false:
		play_music(Bgm)
