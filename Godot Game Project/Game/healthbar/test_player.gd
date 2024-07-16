extends CharacterBody2D

class_name testPlayer

signal healthChanged
@export var maxHealth = 30
@onready var currentHealth: int = maxHealth

var isHurt: bool = false

@export var speed: int = 35

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed

func _physics_process(delta):
	handleInput()
	move_and_slide()
	#updateAnimation()
	#if !isHurt:
	#	for area in hurtBox.get_overlapping_areas():
	#		if area.name == "hitBox":
	#			hurtByEnemy(area)
				
				
func hurtByEnemy(area):
	currentHealth -= 10
	if currentHealth < 0:
		currentHealth = maxHealth
	
	isHurt = true
	healthChanged.emit() # everytime a player is damaged or regains health

