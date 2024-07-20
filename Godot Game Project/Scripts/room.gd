class_name Rooms extends Node2D

@onready var phone_ring = $PhoneRing as AudioStreamPlayer2D
@onready var phone_object = $Collidables/CollisionShape2D/PhoneObject
@onready var bgm = $BGM as AudioStreamPlayer2D

@export var dialogue_resource: DialogueResource
var player_node : Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	get_player(player_node)
	DialogueFunctions.connect("dialogue_finished", Callable(self, "on_dialogue_finished"))
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
func on_dialogue_finished():
	DialogueFunctions.start_player_physics()
	
#function to handle dialogue sequence
func Dialogue_Handler() -> void:
	DialogueFunctions.dialogue_resource = dialogue_resource
	DialogueFunctions.stop_player_physics()
	DialogueFunctions.playDialogue("DayOne")
	DialogueFunctions.playDefaultDialogue("Monologue1")

# Pause Player movement on contact to set animation to idle
func _on_contact():
	$Player.set_physics_process(false)

func unpause_player_movement():
	$Player.set_physics_process(true)
	pass


func _on_actionable_interacted():
	stop_music(phone_ring)	
	play_music(bgm)
