extends Control

var player
@onready var anim = $EffectAnimations
# setup player signal connection to battlescene effects
func set_player(unit):
	player = unit
	player.player_damaged.connect(blood_effect)

func blood_effect():
	anim.play("damage_taken")
