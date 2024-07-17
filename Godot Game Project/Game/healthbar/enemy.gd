extends CharacterBody2D

#enemyMovement
var startPosition
var endPosition
@export var speed = 20
@export var distanceLimit = 0.5

#enemy animation
@onready var animations = $EnemySprite

#enemy health
@onready var healthbar = $"../CanvasLayer/healthBar2"
@onready var health = 6

func _ready():
	startPosition = position
	endPosition = startPosition + Vector2(0, 3 * 16)
	#above makes it 3 times the height of one tile above the character
	#healthbar.init_health(health)
	

func _set_health(value):
	healthbar.health = health

#change direction once it hits end of specified path
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < distanceLimit:
		changeDirection()
		
	velocity = moveDirection.normalized() * speed

func playAnimation():
	var animationString = "idle"
	animations.play(animationString)

func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	playAnimation()
