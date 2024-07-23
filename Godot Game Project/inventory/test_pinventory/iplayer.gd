### Player.gd
extends CharacterBody2D

# Scene-Tree Node references
@onready var inventory_ui = $InventoryUI
@onready var interact_ui = $InteractUI
@onready var animated_sprite = $AnimatedSprite2D

# Variables
@export var speed = 200

func _ready():
	# Set this node as the Player node, cross check with Global autoload script
	GlobalPinventory.set_player_reference(self)

# Input for movement
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

# Movement & Animation
func _physics_process(delta):
	get_input()
	move_and_slide()
	update_animation()

# Animation
func update_animation():
	if velocity == Vector2.ZERO:
		animated_sprite.play("default")
	#else:
	#	if abs(velocity.x) > abs(velocity.y):
	#		if velocity.x > 0:
	#			animated_sprite.play("walk_right")
	#		else:
	#			animated_sprite.play("walk_left")
	#	else:
	#		if velocity.y > 0:
	#			animated_sprite.play("walk_down")  
	#		else:
	#			animated_sprite.play("walk_up")

# Show inventory menu on "I" pressed
func _input(event):
	if event.is_action_pressed("ui_inventory"):
		inventory_ui.visible = !inventory_ui.visible
		get_tree().paused = !get_tree().paused
