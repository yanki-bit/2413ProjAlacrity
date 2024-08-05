extends Sprite2D

var player
@onready var anim = $PlayerSpriteAnimation

func set_player(unit):
	player = unit
	player.player_damaged.connect(hit)

func hit():
	anim.play("hit")
	print("dont speak")
	anim.queue("default")

